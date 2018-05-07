# frozen_string_literal: true

class BandPolicy
  def initialize(band:, params:)
    @band = band
    @params = params
  end

  def can_create_band?
    true
  end
end
