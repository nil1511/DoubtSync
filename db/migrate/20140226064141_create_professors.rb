class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile
      t.boolean :gender
      t.date :dob
      t.integer :spamrate
      t.integer :user_id
      t.text :aoi #Area of interest
      t.attachment :resume
      t.text :topics_covered #course taught

      t.timestamps
    end
  end
end
