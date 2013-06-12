class Email < ActiveRecord::Base
  attr_accessible :content, :from_user, :title, :to_user, :mark_read

  before_save { |email| email.to_user = to_user.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com+\z/i
  validates :to_user, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :title, presence: true
  validates :content, presence: true

  default_scope order: 'emails.created_at DESC'
  end
