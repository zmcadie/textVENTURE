class StatesController < GamesController

  def update
    action = form_params
    update_state_log(action[:trigger])
    clean_trigger = clean_user_input(form_params['trigger'])

    if clean_trigger == 'help'
      actions_helper
      state_id = session[:state_id]
    elsif aprox_trigger?(clean_trigger)
      state_id = aprox_trigger?(clean_trigger)
      state = State.find(state_id)
      update_state_log(state.description)
    else
      state_id = session[:state_id]
      update_state_log('Sorry I don\'t know what that means')
    end
    redirect_to action: 'show', id: state_id
  end

  def clean_user_input(input)
    cleansed_input = input.strip.downcase.split.join(" ")
    cleansed_input
  end

  private

  def aprox_trigger?(user_input)
    next_state_id = nil
    Action.where({ state_id: session['state_id'] }).find_each do |action|
      trigger_words = action.trigger.split
      if trigger_words.any? { |word| user_input.include?(word) }
        next_state_id = action.result_id
      end
    end
    next_state_id
  end

  def actions_helper
    available_actions = ""
    Action.where({ state_id: session['state_id'] }).find_each do |trigger|
      available_actions += trigger.trigger + " "
    end
    action = "Maybe try: #{available_actions}"
    update_state_log(action)
    action
  end

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end