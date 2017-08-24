class CreateSaveStates < ActiveRecord::Migration[5.1]
  def change
    create_table :save_states do |t|
      t.string :user_email
      t.integer :game_id
      t.integer :state_id

      t.timestamps
    end
  end
end
