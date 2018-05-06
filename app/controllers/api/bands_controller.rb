# frozen_string_literal: true

module Api
  class BandsController < ApiController
    before_action :load_band, except: %i[index create]
    before_action :build_or_load_user, only: :create
    before_action :build_band, only: :create

    def index
      handle_index(Band, index_params)
    end

    def show
      handle_show(@band)
    end

    def create
      if band_policy.can_create_band?
        begin
          @user.transaction do
            @user.save! if @user.new_record?
            @band.save!
            
            build_band_membership
            @band_membership.save!
          end

        rescue ActiveRecord::RecordInvalid => invalid
          render(
            status: :unprocessable_entity, 
            json: {
              errors: invalid || 'Could not create band.'
            }
          ) && return
        end
        
        render(
          status: :ok,
          json: {
            user: @user,
            band: @band,
            band_membership: BandMembership.last
          }
        ) && return
      end
      render(
        status: :unauthorized,
        json: {
          errors: 'Unauthorized.'
        }
      ) && return
    end

    def update
    end
    
    def destroy
    end

    private

    def create_params
      params.require(:band)
        .permit(:name, :genre, :bio, :profile_image_url)
    end

    def create_user_params
      params.require(:user)
        .permit(:name, :email)
    end

    def create_band_membership_params
      params.require(:band_membership)
        .permit(:access_level)
    end

    def build_band
      @band = BandService::Create.call( 
        params: create_params
      )
    end

    def load_band
      @band = Band.find_by(params[:id])
    end

    def build_or_load_user
      if params[:user_id]
        @user = User.find_by(params[:id])
      else
        @user = UserService::Create.call(
          params: create_user_params
        )
      end
    end

    def build_band_membership
      @band_membership = BandMembershipService::Create.call(
        user: @user,
        band: @band,
        params: create_band_membership_params
      )
    end

    def band_policy(params: nil)
      BandPolicy.new(
        band: @band || nil,
        params: params
      )
    end
  end
end
