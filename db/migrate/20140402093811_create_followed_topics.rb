class CreateFollowedTopics < ActiveRecord::Migration
  def change
    create_table :followed_topics do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
