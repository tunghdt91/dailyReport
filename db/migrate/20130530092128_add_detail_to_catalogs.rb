class AddDetailToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :detail, :string
  end
end
