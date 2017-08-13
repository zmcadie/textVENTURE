class GamesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to action: 'show', id: session[:state_id]
    else
      update_state_log(State.find(1).description)
      redirect_to action: 'show', id: 1
    end
  end

  def show
    game = Game.find(params[:game_id])
    session[:game_id] = game.id
    session[:state_id] = game.initial_state_id
    @log = @@state_log
    @session = session
  end

  def update_state_log(input)
    @@state_log.push(">> #{input}")
  end
end
