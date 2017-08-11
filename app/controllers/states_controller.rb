class StatesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to action: 'show', id: session[:state_id]
    else
      redirect_to action: 'show', id: 1
    end
  end

  def show
    @state = State.find(params[:id])
    @@state_log.push(@state.description)
    @log = @@state_log
    session[:state_id] = params[:id]
    @session = session[:state_id]
  end

  def update
    @action = form_params
    @@state_log.push(">> #{@action[:trigger]}")
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