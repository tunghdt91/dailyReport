class User < ActiveRecord::Base
  attr_accessible :active, :admin, :md5, :email, :password, :password_confirmation, :group_id, :group_manager, :avatar_path
  has_secure_password
  has_many :reports
  belongs_to :group

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  default_scope order: 'users.created_at DESC'

   def as_xls(options = {})
  {
      "Id" => id.to_s,
      "E-Mail" => email,
      "Joined" => created_at
    }
  end




  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end