class AddDefaultValueToPublish < ActiveRecord::Migration[5.1]
  def change
    change_column :games, :publish, :boolean, default: false
  end
end
