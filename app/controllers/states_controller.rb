class StatesController < GamesController

  def update
    action = form_params
    update_state_log(action[:trigger])
    handle_user_input(action[:trigger])
    clean_trigger = clean_user_input(form_params['trigger'])

    if aprox_trigger?(clean_trigger)
      new_state_id = aprox_trigger?(clean_trigger)
      session[:state_id] = new_state_id
      description = State.find(new_state_id).description
      update_state_log(description)
    else
      state_id = session[:state_id]
      update_state_log('Sorry I don\'t know what that means')
    end
    if not performed?
      redirect_to "/games/#{session[:game_id]}/states/#{session[:state_id]}"
    end
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

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end