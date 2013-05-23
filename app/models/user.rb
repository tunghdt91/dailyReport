class User < ActiveRecord::Base
  attr_accessible :active, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
