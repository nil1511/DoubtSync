class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :mobile
      t.boolean :gender
      t.date :dob
      t.string :degree
      t.integer :graduate_year
      t.integer :spamrate
      t.integer :user_id
      t.attachment :resume
      t.timestamps
    end
  end
end
