class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.integer :state_id
      t.string :trigger
      t.integer :result_id

      t.timestamps
    end
  end
end
