class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :active, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
