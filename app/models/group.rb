class Group < ActiveRecord::Base
  attr_accessible :manager, :user_id, :group_id,:r,:e,:d
  has_many :users
end
