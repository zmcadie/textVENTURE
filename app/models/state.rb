class State < ApplicationRecord
  belongs_to :game
  has_many :actions, dependent: :destroy
  has_many :save_states, dependent: :destroy

  validates :name, :description, presence: true
end
