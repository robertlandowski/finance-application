class AddDisplayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display, :boolean, default: true
  end
end
