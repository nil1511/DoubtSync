class CreateBlockUsers < ActiveRecord::Migration
  def change
    create_table :block_users do |t|
    	t.integer :blocker_id
    	t.integer :blocked_id

      t.timestamps
    end
  end
end
