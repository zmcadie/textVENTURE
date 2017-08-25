class AddDescriptionToActions < ActiveRecord::Migration[5.1]
  def change
    add_column :actions, :description, :text
  end
end
