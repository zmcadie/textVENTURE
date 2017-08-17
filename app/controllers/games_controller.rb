class GamesController < ApplicationController
  @@state_log = []

  def index
    # display games index list
    @@state_log = []
    @games = display_games_index
  end

  def show
    # render each new game state, along with history (state_log)
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
      if @initial_state.save
        @game.initial_state_id = @initial_state.id
        @game.save
        redirect_to "/games/new/#{@game.id}/states"
      else
        redirect_back fallback_location: { action: 'new'}
        flash[:notice] = 'something went wrong with saving the state!'
      end
    else
      redirect_back fallback_location: { action: 'new'}
      flash[:notice] = 'something went wrong with creating the game!'
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
      redirect_back fallback_location: { action: 'states'}
      flash[:notice] = 'something went wrong saving this state!'
    end
  end

  def states_show
    #show each state's info
  end

  def connections
    # first view for creating connections
  end

  def connections_show
   # view for adding actions to states (form)
  end

  def create_connections
    # add actions to states
    @action = Action.new(state_id: params[:state_id], trigger: new_action_params[:trigger_word], result_id: new_action_params[:second_state])
    if @action.save
      redirect_back fallback_location: { action: 'connections_show'}
      flash[:notice] = "new action added to #{State.find_by(id: @action.state_id).name}!"
    else
      flash[:notice] = 'something went wrong!'
    end
  end

  def select
    # select which game to play from games index list
    game_name = game_selection_form[:game_name].strip
    new_game = Game.find_by name: game_name
    if new_game == nil
      flash[:notice] = "No games with that name in here!"
      redirect_back fallback_location: { action: 'index' }
    else
      session[:game_id] = new_game.id
      session[:state_id] = new_game.initial_state_id

      description = State.find(new_game.initial_state_id).description
      logItem = {
        type: 'game',
        value: description
      }
      update_state_log(logItem)

      redirect_to "/games/#{new_game.id}"
    end
  end

  # push new state description to history aka state_log
  def update_state_log(input)
    @@state_log.push(input)
  end

  # displays a list of the names of published games
  def display_games_index
    index = ['Welcome to textVENTURE! Please choose a game from the selection below:']
    Game.all.each do |game|
      index.push(game.name)
    end
    index.push('Simply type the name of the game you wish to play, and hit enter')
  end

  # Remove whitespacing, make downcase
  def clean_user_input(input)
    cleansed_input = input.strip.downcase.split.join(" ")
    cleansed_input
  end

  # is this a system message? (or an action trigger word)
  def system_message?(user_input)
    user_input[0, 2] == '--'
  end

  # remove dashes prefixing all system messages
  def slice_dashes(user_input)
    user_input[0, 2] = ""
    user_input
  end

  # does any part of the sentence typed in by the user contain an actrion trigger word?
  def aprox_trigger?(user_input)
    next_state_id = nil
    Action.where({ state_id: session['state_id'] }).find_each do |action|
      trigger_words = action.trigger.split
      if trigger_words.any? { |word| user_input.include?(word) }
        next_state_id = action.result_id
      end
    end
    next_state_id
  end

  # method called in update#states_controller
  # determines if user input is an action trigger word or a system command
  # updates state log and redirects accordingly
  def handle_user_input(user_input)
    clean_input = clean_user_input(user_input)

    if system_message?(clean_input) # Is it a system-type message?
      keyword = slice_dashes(clean_input) # If yes, slice off the dashes
      command = "command_#{keyword}"
      if respond_to? command # Does this command actually exist in games controller?
        send command # If yes, then execute that command
      else
        logItem = {
          type: 'game',
          value: 'Sorry, that system command does not exist'
        }
        update_state_log(logItem)
      end
    else # If not a system message, then it is a user action # So take their trigger and find the next_state_id
      if aprox_trigger?(clean_input)
        new_state_id = aprox_trigger?(clean_input)
        session[:state_id] = new_state_id
        description = State.find(new_state_id).description
        logItem = {
          type: 'game',
          value: description
        }
        update_state_log(logItem)
      else
        state_id = session[:state_id]
        logItem = {
          type: 'system',
          value: 'Sorry I don\'t know what that means'
        }
        update_state_log(logItem)
      end
    end

    if not performed?
      redirect_to "/games/#{session[:game_id]}"
    end
  end

  # redirected here when "--help" system message is detected
  def command_help
    display_possible_actions
  end

  # redirected here when "--quit" system message is detected
  def command_quit
    reset_session
    @@state_log = []
    redirect_to "/"
  end

  # returns a list of the possible actions a user could take in the given game state
  def display_possible_actions
    available_actions = ""
    Action.where({ state_id: session['state_id'] }).find_each do |trigger|
      available_actions += trigger.trigger + " "
    end
    actions_list = available_actions.strip.split.join(", ")
    action = "Maybe try one of: #{actions_list}"
    logItem = {
      type: 'system',
      value: action
    }
    update_state_log(logItem)
    action
  end

  # FORMS #
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

  def new_action_params
    params.require(:new_action).permit(
      :second_state,
      :trigger_word
      )
  end
end
