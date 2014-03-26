class CreateUpComingColleges < ActiveRecord::Migration
  def change
    create_table :up_coming_colleges do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
