class CreateRights < ActiveRecord::Migration[7.1]
  def change
    create_table :rights do |t|
      t.string :role
      t.integer :user_id
      t.integer :language_id

      t.timestamps
    end
  end
end
