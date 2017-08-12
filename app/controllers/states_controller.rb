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
    state = State.find(params[:id])
    if state
      session[:state_id] = state[:result_id]
      @@state_log.push(state.description)
      session[:state_id] = params[:id]
    else
      @@state_log.push('Sorry I don\'t know what that means')
    end
    @log = @@state_log
    @session = session[:state_id]
  end

  def update
    clean_trigger = clean_user_input(form_params['trigger'])
    if clean_trigger == 'help'
      actions_helper
    end
    action = form_params
    @@state_log.push(">> #{action[:trigger]}")
    state = Action.where({ state_id: action[:state_id], trigger: clean_trigger }).first
    if state
      state_id = state.result_id
    else
      state_id = session[:state_id]
    end
    redirect_to action: 'show', id: state_id
  end

  def clean_user_input(input)
    cleansed_input = input.strip.downcase.split.join(" ")
    cleansed_input
  end

  private

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

  def actions_helper
    @available_actions = ""
    Action.where({ state_id: session['state_id'] }).find_each do |trigger|
      @available_actions += trigger.trigger << "\n"
    end
    @@state_log.push("Maybe try: #{@available_actions}")
  end

  def form_params
    params.require(:user_input).permit(
      :trigger,
      :state_id
    )
  end
end