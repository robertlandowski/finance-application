class AddRecurringtimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurringtime, :integer
  end
end
