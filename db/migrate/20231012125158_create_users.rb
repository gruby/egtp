class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :admin
      t.boolean :active, default: true
      t.boolean :notifications, default: true
      t.string :name 
      t.string :nick 
      t.integer :language_id
      t.string :phone
      t.string :address
      t.string :country

      t.timestamps
    end
  end
end
