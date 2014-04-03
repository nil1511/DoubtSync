class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.text :tagged_users
      t.text :htags
      t.boolean :visibility_to_prof
      t.string :spam
      t.integer :user_id      
      t.text :upvotes
      t.text :downvotes
      t.attachment :document
      t.timestamps
    end
  end
end
