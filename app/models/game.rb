class Game < ApplicationRecord
  has_many :states

  validates :name, :initial_state_id, presence: true
end
