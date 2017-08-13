class GamesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to "games/#{session[:game_id]}/states/#{session[:state_id]}"
    else
      games = find_all_game_descriptions
      update_state_log(games)
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

  def find_all_game_descriptions
    games = ""
    Game.all.each do |game|
      game += game.name + " "
    end
    games
  end
end