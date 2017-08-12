class GamesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to action: 'show', id: session[:state_id]
    else
      @@state_log.push(State.find(1).description)
      redirect_to action: 'show', id: 1
    end
  end

  def show
    state = State.find(params[:id])
    session[:state_id] = params[:id]
    @log = @@state_log
    @session = session[:state_id]
  end

  def update_state_log
  end
end
