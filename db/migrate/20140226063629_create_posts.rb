class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.string :tag
      t.integer :student_id
      t.datetime :time
      t.integer :spamrate
      t.integer :visibility_to_prof

      t.timestamps
    end
  end
end
