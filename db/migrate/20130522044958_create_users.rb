class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.boolean :active, default: false
      t.boolean :admin, default: false
      t.string  :md5
      t.integer :group_id
      t.string  :avatar_path
      t.boolean :group_manager,  default: false
      t.timestamps
    end
  end
end
