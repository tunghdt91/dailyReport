class CreateNamegroups < ActiveRecord::Migration
  def change
    create_table :namegroups do |t|
      t.integer :group_id
      t.string :group_name

      t.timestamps
    end
  end
end
