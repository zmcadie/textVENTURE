class StatesController < GamesController

  def update
    # takes in user action, redirects to next state
    action = form_params
    logItem = {
      type: 'user',
      value: ">> #{action[:trigger]}"
    }
    update_state_log(logItem)
    handle_user_input(action[:trigger])
  end

  private

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end