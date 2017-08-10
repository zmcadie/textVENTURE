class StatesController < ApplicationController
  def index
    redirect_to action: 'show', id: 1
  end

  def show
    @state = State.find(params[:id])
    session[:state_id] = params[:id]
    @session = session[:state_id]
  end

  def update
    @action = form_params
    @state_id = Action.where({ state_id: @action[:state_id], trigger: @action[:trigger] }).first.result_id
    redirect_to action: 'show', id: @state_id
  end

  private

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end