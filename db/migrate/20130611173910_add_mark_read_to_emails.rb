class AddMarkReadToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :mark_read, :boolean,default: false
  end
end
