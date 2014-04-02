class CreateTopicPosts < ActiveRecord::Migration
  def change
    create_table :topic_posts do |t|
      t.integer :post_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
