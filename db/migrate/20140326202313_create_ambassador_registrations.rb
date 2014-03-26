class CreateAmbassadorRegistrations < ActiveRecord::Migration
  def change
    create_table :ambassador_registrations do |t|
		t.string   :name
		t.string   :email
		t.string   :authcode
		t.string   :college_name

      t.timestamps
    end
  end
end
