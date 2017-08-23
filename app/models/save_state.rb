class SaveState < ApplicationRecord
  belongs_to :game
  belongs_to :state

  validates :user_email, presence: true
  validates :game_id, presence: true
  validates :user_id, presence: true

  def save_game(email)
  end
end
