class Report < ActiveRecord::Base
  attr_accessible :catalog_id, :content, :file_name, :file_path
end
