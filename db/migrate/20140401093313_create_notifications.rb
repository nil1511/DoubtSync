class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :text
      t.integer :user_id
      t.integer :read
      t.text :url

      t.timestamps
    end
  end
end
