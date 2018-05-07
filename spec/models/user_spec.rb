require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @band = FactoryBot.create(:band)
    @membership = FactoryBot.create(:band_membership, band_id: @band.id, user_id: @user.id)  
  end

  it "properly associates with band through membership" do
    expect(@user.reload.bands.find_by(id: @band.id)).to eq(@band)
  end
end
