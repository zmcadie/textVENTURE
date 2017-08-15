class State < ApplicationRecord
  belongs_to :game
  has_many :actions

  validates :name, :description, presence: true
end
