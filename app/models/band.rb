class Band < ApplicationRecord
  has_many :band_memberships
  has_many :users, through: :band_memberships

  validates :name, presence: true
  validates :bio, presence: true
  validates :profile_image_url, presence: true
  validates :genre, presence: true
end
