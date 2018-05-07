require 'rails_helper'

RSpec.describe Band, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @band = FactoryBot.create(:band)
  end

  it "properly associates with a user and band membership" do
    membership = FactoryBot.create(:band_membership, band_id: @band.id, user_id: @user.id)
    expect(@band.reload.users.find_by(id: @user.id)).to eq(@user)
  end
end
