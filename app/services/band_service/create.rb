# frozen_string_literal: true

module BandService
  class Create
    def initialize(params)
      @params = params

      build
    end

    def self.call(params:)
      new(params).call
    end

    def call
      @record
    end

    private

    def build
      @record = Band.new(@params)
    end
  end
end
