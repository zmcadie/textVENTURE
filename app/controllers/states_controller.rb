class StatesController < ApplicationController
  def index
    if session[:state_id]
      redirect_to action: 'show', id: session[:state_id]
    else
      redirect_to action: 'show', id: 1
    end
  end

  def show
    @state = State.find(params[:id])
    session[:state_id] = params[:id]
    @session = session[:state_id]
  end

  def update
    @action = form_params
    @state = Action.where({ state_id: @action[:state_id], trigger: @action[:trigger] }).first
    if @state
      session[:state_id] = @state.result_id
    end
    redirect_to action: 'show', id: session[:state_id]
  end

  private

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end