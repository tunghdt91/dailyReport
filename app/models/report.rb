class Report < ActiveRecord::Base
  attr_accessible :catalog_id, :content, :file_name, :file_path, :user_id
  belongs_to :user

  validates :content, presence: true
  validates :catalog_id, presence: true

default_scope order: 'reports.created_at DESC'
end
