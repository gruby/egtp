class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.integer :language_id
      t.string :media
      t.integer :status
      t.string :title
      t.string :description
      t.text :content
      t.integer :user_id
      t.integer :item_id
      t.string :context_info
      t.boolean :published

      t.timestamps
    end
  end
end
