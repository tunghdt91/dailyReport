class AddGroupIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :group_id, :integer
  end
end
