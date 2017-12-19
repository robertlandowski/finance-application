class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :yearly
      t.integer :monthly
      t.integer :weekly
      t.integer :daily

      t.timestamps null: false
    end
  end
end
