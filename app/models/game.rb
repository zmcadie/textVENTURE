class Game < ApplicationRecord
  has_many :states

  validates :name, presence: true
  validates :name, uniqueness: true
end
