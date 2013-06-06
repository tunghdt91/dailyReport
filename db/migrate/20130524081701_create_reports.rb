class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :catalog_id
      t.string :content
      t.string :file_name
      t.string :file_path
      t.integer :user_id
      t.timestamps
    end
  end
end
