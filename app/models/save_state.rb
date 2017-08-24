class SaveState < ApplicationRecord
  belongs_to :game
  belongs_to :state

  validates :user_email, presence: true
  validates :game_id, presence: true
  validates :state_id, presence: true

  def self.save_game(state_obj)
    if state_obj[:user_email]
      save_state = SaveState.create_with(state_id: state_obj[:state_id]).find_or_create_by!(user_email: state_obj[:user_email], game_id: state_obj[:game_id])
      message = "game saved, #{save_state[:user_email]}"
    else
      message = 'please provide an email, type "--save <your email here>"'
    end
    message
  end

  def self.load_game(state_obj)
    save_state = SaveState.find_by(state_obj)
    if save_state
      response = {type: 'game', value: State.find(save_state.state_id).description}
      state_id = save_state[:state_id]
    else
      value = state_obj[:user_email] ? 'sorry, I don\'t recognize that email' : 'please provide an email, type "--load <your email here>"'
      response = {type: 'system', value: value}
      state_id = state_obj[:state_id]
    end
    return response, state_id
  end
end
