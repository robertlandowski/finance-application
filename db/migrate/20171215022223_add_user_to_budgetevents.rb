class AddUserToBudgetevents < ActiveRecord::Migration
  def change
    add_column :budgetevents, :user_id, :integer
    add_index :budgetevents, :user_id
  end
end
