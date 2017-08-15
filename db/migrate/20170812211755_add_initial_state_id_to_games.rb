class AddInitialStateIdToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :initial_state_id, :integer
  end
end
