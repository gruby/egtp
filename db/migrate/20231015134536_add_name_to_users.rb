class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :nick, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :notifications, :boolean, :default => true
    add_column :users, :active, :boolean, :default => true
  end
end
