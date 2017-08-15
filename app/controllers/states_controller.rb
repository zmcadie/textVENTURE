class StatesController < GamesController

  def update
    action = form_params
    update_state_log(action[:trigger])
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