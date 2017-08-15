class AddGameIdToStates < ActiveRecord::Migration[5.1]
  def change
    add_reference :states, :game, foreign_key: true
  end
end
