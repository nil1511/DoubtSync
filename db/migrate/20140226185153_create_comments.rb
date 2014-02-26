class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.text :tag
      t.integer :user_id
      t.integer :post_id
      t.integer :spamrate

      t.timestamps
    end
  end
end
