class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :yearly
      t.integer :monthly
      t.integer :weekly
      t.integer :daily

      t.timestamps null: false
    end
  end
end
