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
    @log = @@state_log
    @state_id = session[:state_id]
  end

  def new
    #render new game form
  end

  def create
    # add Game.new
    game_name = new_game_params[:game_title]
    @game = Game.new(name: game_name)
    if @game.save
      @initial_state = State.new(name: new_game_params[:state_name], description: new_game_params[:beginning_state], game_id: @game.id)
      @initial_state.save
      @game.initial_state_id = @initial_state.id
      redirect_to "/games/new/#{@game.id}/states"
    else
      redirect_back fallback_location: { action: 'new'}
      flash[:notice] = 'something went wrong!'
    end
  end

  def states
    #render add states form
  end

  def states_create
    # add State.new to new game
    # view states' info
    @game = Game.find(params[:new_id])
    @state = State.new(name: new_state_params[:state_name], description: new_state_params[:state_description], game_id: @game.id)
    if @state.save
      redirect_back fallback_location: { action: 'states'}
    else
      flash[:notice] = 'something went wrong!'
    end
  end

  def states_show
    #show each state's info
  end


  def connections
    # add actions to states
  end

  def select
    game_name = game_selection_form[:game_name].strip
    new_game = Game.find_by name: game_name
    if new_game == nil
      flash[:notice] = "No games with that name in here!"
      redirect_back fallback_location: { action: 'index' }
    else
      session[:game_id] = new_game.id
      session[:state_id] = new_game.initial_state_id

      description = State.find(new_game.initial_state_id).description
      update_state_log(description)

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

  def new_game_params
    params.require(:new_game).permit(
      :game_title,
      :state_name,
      :beginning_state
      )
  end

  def new_state_params
    params.require(:add_states).permit(
      :state_name,
      :state_description
      )
  end
end