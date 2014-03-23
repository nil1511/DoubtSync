class CreateAddUserIdToStudentAndProfessors < ActiveRecord::Migration
  def change
    add_column :students, :user_id, :integer
    add_column :professors, :user_id, :integer
  end
end
