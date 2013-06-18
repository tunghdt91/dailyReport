class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :manager
      t.boolean :r, default: true
      t.boolean :e, default:  false
      t.boolean :d, default: false
      t.timestamps
    end
  end
end
