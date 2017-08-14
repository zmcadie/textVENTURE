class GamesController < ApplicationController
  @@state_log = []

  def index
    if session[:state_id]
      redirect_to "/games/#{session[:game_id]}/states/#{session[:state_id]}"
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

  def new
  end

  def create
    game_name = new_game_params[:game_title]
    @game = Game.new(name: game_name)
    @state_name = new_game_params[:state_name]
    if @game.save
      @initial_state = State.new(description: new_game_params[:beginning_state], game_id: @game.id)
      @initial_state.save
      @game.initial_state_id = @initial_state.id
      redirect_to "/games/#{@game.id}/states"
    else
      render :new, notice: 'something went wrong!'
    end
# add Game.new
  end

  def states
    # add State.new to new game
    # view states' info
  end

  def connections
    # add actions to states
  end

  def select
    game_name = game_selection_form[:game_name].strip
    new_game = Game.find_by name: game_name
    if new_game == nil
      update_state_log("No games with that name in here!")
      redirect_to action: 'index'
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

  def new_game_params
    params.require(:new_game).permit(
      :game_title,
      :state_name,
      :beginning_state
      )
  end
end