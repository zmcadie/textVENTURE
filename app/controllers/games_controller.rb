class GamesController < ApplicationController
  @@state_log = []

  def index
    # display games index list
    @@state_log = []
    @games = display_games_index
  end

  def show
    # render each new game state, along with history (state_log)
    if @@state_log == []
      redirect_to '/'
    else
      @log = @@state_log
      @state_id = session[:state_id]
    end
  end

  def new
    #render new game form
  end

  def create
    # add Game.new
    game_name = new_game_params[:game_title]
    @game = Game.new(name: game_name)
    if @game.save
      @initial_state = State.new(
        name: new_game_params[:state_name],
        description: new_game_params[:beginning_state],
        game_id: @game.id
      )
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
    @state = State.new(
      name: new_state_params[:state_name],
      description: new_state_params[:state_description],
      game_id: @game.id
    )
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
    @action = Action.new(
      state_id: params[:state_id],
      trigger: new_action_params[:trigger_word],
      result_id: new_action_params[:second_state],
      description: new_action_params[:action_desc]
    )
    if @action.save
      redirect_back fallback_location: { action: 'connections_show'}
      flash[:notice] = "new action added to #{State.find_by(id: @action.state_id).name}!"
    else
      flash[:notice] = 'something went wrong!'
    end
  end

  def save_game
    # toggle publish to true
    @game = Game.find(params[:new_id])
    @game.publish = true
    if @game.save
      redirect_to "/"
      flash[:notice] = "your game has been saved!"
    else
      redirect_back fallback_location: { action: 'states'}
      flash[:notice] = "there was a problem submitting your game!"
    end
  end

  def discard_game
    @game = Game.find(params[:new_id])
    if @game.destroy
      redirect_to "/"
      flash[:notice] = "your game was discarded"
    else
      redirect_back fallback_location: { action: 'states'}
      flash[:notice] = "something went wrong discarding your game"
    end
  end

  def select
    # select which game to play from games index list
    game_name = game_selection_form[:game_name].strip
    new_game = Game.where("lower(name) = ?", game_name.downcase).first
    if new_game == nil
      flash[:notice] = "No games with that name in here!"
      redirect_back fallback_location: { action: 'index' }
    else
      session[:game_id] = new_game.id
      session[:state_id] = new_game.initial_state_id

      description = State.find(new_game.initial_state_id).description
      update_state_log('game', description)
      redirect_to "/games/#{new_game.id}"
    end
  end

  # push new state description to history aka state_log
  def update_state_log(type, value)
    logItem = {
      type: type,
      value: value
    }
    @@state_log.push(logItem)
  end

  # displays a list of the names of published games
  def display_games_index
    index = ['Welcome to textVENTURE! Please choose a game from the selection below:']
    Game.where(publish: true).find_each do |game|
      index.push(game.name)
    end
    index.push('Simply type the name of the game you wish to play, and hit enter')
  end

  # returns a list of the possible actions a user could take in the given game state
  def display_possible_actions
    available_actions = ""
    Action.where({ state_id: session['state_id'] }).find_each do |trigger|
      available_actions += trigger.trigger + " "
    end
    actions_list = available_actions.strip.split.join(", ")
    action = "Maybe try one of: #{actions_list}"
    update_state_log('system', action)
    action
  end

  #/////////////////////////////////////////////////#
  #/////                                         ///#
  #//// Helper functions for parsing user input ////#
  #///                                         /////#
  #/////////////////////////////////////////////////#

  # Remove whitespacing, make downcase
  def clean_user_input(input)
    cleansed_input = input.strip.downcase.split.join(" ")
    cleansed_input
  end

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
    action_info = nil
    Action.where({ state_id: session['state_id'] }).find_each do |action|
      trigger_words = action.trigger.split
      if trigger_words.any? { |word| user_input.include?(word) }
        action_info = action
      end
    end
    action_info
  end

  def handle_system_message(clean_input)
    keyword = slice_dashes(clean_input).split(" ")
    command = "command_#{keyword[0]}"
    if respond_to? command # Does command exist?
      if keyword[1]
        send command, keyword[1]
      else
        send command
      end
    else
      update_state_log('system', 'Sorry, that system command does not exist')
    end
  end

  def handle_action(action)
    action_description = action.description
    update_state_log('game', action_description)

    session[:state_id] = action.result_id

    new_state_description = State.find(action.result_id).description
    update_state_log('game', new_state_description)
  end

  # method called in update#states_controller
  # determines if user input is an action trigger word or a system command
  # updates state log and redirects accordingly
  def handle_user_input(user_input)
    clean_input = clean_user_input(user_input)

    if system_message?(clean_input)
      handle_system_message(clean_input)

    # If action exists:
    elsif aprox_trigger?(clean_input)
      action = aprox_trigger?(clean_input)
      handle_action(action)

    else
      state_id = session[:state_id]
      update_state_log('system', 'Sorry I don\'t know what that means')
    end

    if not performed?
      redirect_to "/games/#{session[:game_id]}"
    end
  end

  #////////////////////////////////////////////////////#
  #/////                                            ///#
  #//// system commands are universal to all games ////#
  #///                                            /////#
  #////////////////////////////////////////////////////#
  def command_help
    display_possible_actions
  end

  def command_quit
    reset_session
    @@state_log = []
    redirect_to "/"
  end

  def command_save(email = nil)
    save_state = {
      user_email: email,
      game_id: session[:game_id],
      state_id: session[:state_id]
    }
    message = SaveState.save_game(save_state)
    update_state_log('system', message)
  end

  def command_load(email = nil)
    save_state = {
      user_email: email,
      game_id: session[:game_id]
    }
    response, state_id = SaveState.load_game(save_state)
    session[:state_id] = state_id
    update_state_log(response[:type], response[:value])
  end

  #/////////////////////#
  #/////             ///#
  #////    FORMS    ////#
  #///             /////#
  #/////////////////////#
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
      :trigger_word,
      :action_desc
      )
  end
end
