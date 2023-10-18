class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :context_info

      t.timestamps
    end
  end
end
