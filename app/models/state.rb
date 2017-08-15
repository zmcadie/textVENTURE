class State < ApplicationRecord
  belongs_to :game
  has_many :actions
end
