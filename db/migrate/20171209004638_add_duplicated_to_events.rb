class AddDuplicatedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :duplicated, :boolean, default: false
  end
end
