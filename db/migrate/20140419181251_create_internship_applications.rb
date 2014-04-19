class CreateInternshipApplications < ActiveRecord::Migration
  def change
    create_table :internship_applications do |t|
      t.integer :internship_id
      t.integer :student_id

      t.text :message
      t.attachment :resume

      t.timestamps
    end
  end
end
