class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name
      t.integer :user_id #ambassador

      t.timestamps
    end
  end
end
