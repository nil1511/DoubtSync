class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :venue
      t.string :duration
      t.datetime :date
      t.text :description
      t.attachment :photo
      t.string :url
      t.integer :college_id
      t.integer :user_id

      t.timestamps
    end
  end
end
