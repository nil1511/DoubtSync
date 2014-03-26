class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text
      t.text :tagged_users
      t.text :htags
      t.boolean :visibility_to_prof
      t.integer :spamrate
      t.integer :user_id
      t.string :upvotes
      t.string :downvotes

      t.timestamps
    end
  end
end
