class Catalog < ActiveRecord::Base
  attr_accessible :name, :detail

  validates :name, presence: true
end