class CreateSregistrations < ActiveRecord::Migration
  def change
    create_table :sregistrations do |t|
      t.integer :role_id
      t.text :email
      t.string :authcode

      t.timestamps
    end
  end
end
