class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bio, :approved

  has_many :bands, through: :band_memberships
end
