class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :edition
      t.text :description
      t.attachment :photo
      t.text :tags
      t.integer :price
      t.string :contact
      t.integer :user_id

      t.timestamps
    end
  end
end
