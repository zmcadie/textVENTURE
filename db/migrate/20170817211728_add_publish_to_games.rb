class AddPublishToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :publish, :boolean
  end
end
