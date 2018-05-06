class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  has_many :band_memberships
  has_many :bands, through: :band_memberships

  before_save { email.downcase! }
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false },
										length: { maximum: 255 }
	has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
