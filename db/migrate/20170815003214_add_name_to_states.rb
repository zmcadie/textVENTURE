class AddNameToStates < ActiveRecord::Migration[5.1]
  def change
    add_column :states, :name, :string
  end
end
