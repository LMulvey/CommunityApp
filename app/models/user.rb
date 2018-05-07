# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  has_many :band_memberships
  has_many :bands, through: :band_memberships

  enum approved: { disabled: -1, unapproved: 0, approved: 1 }
  enum access_level: { member: 0, moderator: 1, admin: 2 }

  before_save { email.downcase! }
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }

	has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Helper Methods
  def is_admin?
    if self.access_level == "admin"
      true
    else
      false
    end
  end

  def is_moderator?
    if self.access_level == "moderator" || access_level == "admin"
      true
    else
      false
    end
  end

end
