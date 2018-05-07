module UserService
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

    def force_save
      if @record.save!
        true
      else
        false
      end
    end

    private

    def build
      if no_password?
        generate_initial_password
      end
      @record = User.new(@params)
    end

    def generate_initial_password(length = 12)
      initial_password = SecureRandom.urlsafe_base64(length, false)
      @params[:initial_password] = initial_password
      @params[:password] = initial_password
      @params[:password_confirmation] = initial_password
    end

    def no_password?
      !@params[:password] && !@params[:password_confirmation]
    end
  end
end
