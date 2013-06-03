class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.boolean :manager

      t.timestamps
    end
  end
end
