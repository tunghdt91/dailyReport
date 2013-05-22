class User < ActiveRecord::Base
  attr_accessible :active, :email, :password, :password_confirmation
  has_secure_password
end
