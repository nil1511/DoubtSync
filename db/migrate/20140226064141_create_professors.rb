class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :first_name
      t.string :last_name
      t.integer :mobile
      t.boolean :gender
      t.date :dob
      t.integer :spamrate
      t.integer :user_id

      t.timestamps
    end
  end
end
