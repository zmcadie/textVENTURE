class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.states :references
      t.string :trigger
      t.integer :result_id

      t.timestamps
    end
  end
end
