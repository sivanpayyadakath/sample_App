class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 },
                        format: { with: valid_email_regexp },
                        uniqueness: { case_sensitive:false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
