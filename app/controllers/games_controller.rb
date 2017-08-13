class GamesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to "games/#{session[:game_id]}/states/#{session[:state_id]}"
    else
      display_games_index
      @log = @@state_log
    end
  end

  def show
    game = Game.find(params[:game_id])
    session[:game_id] = game.id
    session[:state_id] = game.initial_state_id
    @log = @@state_log
    @session = session
  end

  def select
    game_name = game_selection_form[:game_name]
  end

  def update_state_log(input)
    @@state_log.push(">> #{input}")
  end

  def display_games_index
    update_state_log('Welcome to textVENTURE! Please choose a game from the selection below:')
    Game.all.each do |game|
      update_state_log(game.name)
    end
    update_state_log('Simply type the name of the game you wish to play, and hit enter')
  end

  def game_selection_form
    params.require(:user_input).permit(
      :game_name
    )
  end
end