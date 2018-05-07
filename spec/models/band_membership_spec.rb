require 'rails_helper'

RSpec.describe BandMembership, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @band = FactoryBot.create(:band)
  end

  it "properly associates with band and user" do
    membership = FactoryBot.create(:band_membership, band_id: @band.id, user_id: @user.id)
    expect(membership.user.name).to eq(@user.name)
    expect(membership.band.name).to eq(@band.name)
  end
end
