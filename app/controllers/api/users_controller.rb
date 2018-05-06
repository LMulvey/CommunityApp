# frozen_string_literal: true

module Api
  class UsersController < ApiController
    before_action :load_user, except: %i[index create]

    def index
      handle_index(User, index_params)
    end

    def show
      handle_show(@user)
    end

    def create
      if user_policy.can_create_user?
        new_user = UserService::Create(
          params: create_params
        )
        render(
          status: :ok, 
          json: { data: new_user.record }
        ) && return if new_user.record.save!
      end

        create_errors = new_user.errors || 'Could not create user.'
        render(
          status: :unprocessable_entity,
          json: { data: create_errors }
        )
    end

    def update
    end
    
    def destroy
    end

    private

    def create_params
      params.require(:user)
        .permit(:name, :email, :bio, :password, :password_confirmation)
    end

    def load_user
      @user = User.find_by(params[:id])
    end

    def user_policy(params: nil)
      UserPolicy.new(
        user: @user || nil,
        params: params
      )
    end
  end
end
