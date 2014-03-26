class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.text :tagged_users
      t.text :htags
      t.integer :user_id
      t.integer :post_id
      t.integer :spamrate
      t.string :upvotes
      t.string :downvotes

      t.timestamps
    end
  end
end
