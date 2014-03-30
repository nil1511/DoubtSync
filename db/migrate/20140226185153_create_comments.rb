class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.text :tagged_users
      t.text :htags
      t.integer :user_id
      t.integer :post_id
      t.integer :spamrate
      t.text :upvotes
      t.text :downvotes
      t.attachment :document
      
      t.timestamps
    end
  end
end
