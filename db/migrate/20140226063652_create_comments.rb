class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :post_id
      t.string :tag
      t.integer :user_id
      t.datetime :time
      t.integer :spamrate

      t.timestamps
    end
  end
end
