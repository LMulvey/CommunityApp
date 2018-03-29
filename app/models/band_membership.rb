class BandMembership < ApplicationRecord
  belongs_to :user
  belongs_to :band
end
