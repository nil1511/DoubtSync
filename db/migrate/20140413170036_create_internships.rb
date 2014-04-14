class CreateInternships < ActiveRecord::Migration
  def change
    create_table :internships do |t|
      t.integer :professor_id

      t.text :title
      t.text :description
      t.text :tags
      t.date :start_date
      t.text :duration
      t.text :location
      t.date :deadline
      t.text :opening
      t.text :url
      t.text :eligible_students
      t.text :required_skills

      t.timestamps
    end
  end
end
