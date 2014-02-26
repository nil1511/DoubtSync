class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text
      t.text :tag
      t.boolean :visibility_to_prof
      t.integer :spamrate
      t.integer :user_id

      t.timestamps
    end
  end
end
