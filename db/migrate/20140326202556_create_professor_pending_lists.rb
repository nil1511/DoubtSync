class CreateProfessorPendingLists < ActiveRecord::Migration
  def change
    create_table :professor_pending_lists do |t|
    	t.string :name
    	t.string :email
    	t.string :authcode
    	t.integer :college_id

      t.timestamps
    end
  end
end
