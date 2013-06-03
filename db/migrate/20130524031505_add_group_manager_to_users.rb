class AddGroupManagerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_manager, :boolean, default: false
  end
end
