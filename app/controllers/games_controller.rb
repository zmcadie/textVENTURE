class GamesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to "/games/#{session[:game_id]}/states/#{session[:state_id]}"
    else
      @games = display_games_index
    end
  end

  def show
    game_id = params[:game_id]
    state_id = params[:state_id]

    session[:game_id] = game_id
    session[:state_id] = state_id

    description = State.find(state_id).description
    update_state_log(description)

    @log = @@state_log
    @state_id = state_id
  end

  def new

  end

  def select
    game_name = game_selection_form[:game_name].strip
    new_game = Game.find_by name: game_name
    if new_game == nil
      flash[:notice] = "No games with that name in here!"
      redirect_back fallback_location: { action: 'index' }
    else
      redirect_to "/games/#{new_game.id}/states/#{new_game.initial_state_id}"
    end
  end

  def clean_user_input(input)
    cleansed_input = input.strip.downcase.split.join(" ")
    cleansed_input
  end

  def update_state_log(input)
    @@state_log.push(">> #{input}")
  end

  def display_games_index
    index = ['Welcome to textVENTURE! Please choose a game from the selection below:']
    Game.all.each do |game|
      index.push(game.name)
    end
    index.push('Simply type the name of the game you wish to play, and hit enter')
  end

  def game_selection_form
    params.require(:user_input).permit(
      :game_name
    )
  end
end