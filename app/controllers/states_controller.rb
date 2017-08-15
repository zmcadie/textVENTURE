class StatesController < GamesController

  def update
    action = form_params
    logItem = {
      type: 'user',
      value: action[:trigger]
    }
    update_state_log(logItem)
    clean_trigger = clean_user_input(form_params['trigger'])

    if clean_trigger == 'help'
      actions_helper
      state_id = session[:state_id]
    elsif aprox_trigger?(clean_trigger)
      new_state_id = aprox_trigger?(clean_trigger)
      session[:state_id] = new_state_id
      description = State.find(new_state_id).description
      logItem = {
        type: 'game',
        value: description
      }
      update_state_log(logItem)
    else
      state_id = session[:state_id]
      logItem = {
        type: 'system',
        value: 'Sorry I don\'t know what that means'
      }
      update_state_log(logItem)
    end

    redirect_to "/games/#{session[:game_id]}"
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
    logItem = {
      type: 'system',
      value: action
    }
    update_state_log(logItem)
    action
  end

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end