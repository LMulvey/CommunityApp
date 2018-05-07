# frozen_string_literal: true

module BandMembershipService
  class Create
    def initialize(params, user, band)
      @params = params
      @user = user
      @band = band

      build
    end

    def self.call(params:, user:, band:)
      new(params, user, band).call
    end

    def call
      @record
    end

    private

    def build
      @params[:user_id] = @user.id
      @params[:band_id] = @band.id
      @record = BandMembership.new(@params)
    end

    def force_save
      if @record.save!
        true
      else
        false
      end
    end
  end
end
