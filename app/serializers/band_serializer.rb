# frozen_string_literal: true

class BandSerializer < ActiveModel::Serializer
  attributes :id, :name, :genre, :bio

  has_many :users, through: :band_membership
end
