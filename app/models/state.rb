class State < ApplicationRecord
  belongs_to :game
  has_many :actions, dependent: :destroy

  validates :name, :description, presence: true
end
