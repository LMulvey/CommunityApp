module UserService
  class Update
    def initialize(params:, user:)
      @params = params
      @user = user

      build
    end

    def self.call(params)
      new(params).call
    end

    def call
      @user.update(@params)
    end
  end
end
