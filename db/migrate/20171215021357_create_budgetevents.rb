class CreateBudgetevents < ActiveRecord::Migration
  def change
    create_table :budgetevents do |t|
      t.string :title
      t.integer :value
      t.boolean :recurring
      t.integer :recurringtime
      t.boolean :duplicated

      t.timestamps null: false
    end
  end
end
