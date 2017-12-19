class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.integer :value

      t.timestamps null: false
    end
  end
end
