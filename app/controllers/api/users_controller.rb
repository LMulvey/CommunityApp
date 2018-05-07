# frozen_string_literal: true

module Api
  class UsersController < ApiController
    skip_before_action :authenticate, only: :create
    before_action :load_user, except: %i[index create]

    def index
      handle_index(User, index_params)
    end

    def show
      handle_show(@user)
    end

    def create
      if user_policy.can_register?
        new_user = UserService::Create.call(
          params: create_params
        )
        render(
          status: :ok, 
          json: new_user
        ) && return if new_user.save!
      end
        create_errors = new_user.errors || 'Could not create user.'
        render(
          status: :unprocessable_entity,
          json: { error: create_errors }
        )
    end

    def update
      @user.attributes = update_params
      puts "hey it's #{params[:id]}"
      if @user.save!(:validate => false)
        render(
          status: :ok,
          json: { user: @user }
        ) && return
      end

      render(
        status: :unprocessable_entity,
        json: { error: @user.errors }
      )
    end
    
    def destroy
      render(
        status: :not_found,
        json: { error: 'Please contact administrator.' }
      )
    end

    private

    def create_params
      params.require(:user)
        .permit(:name, :email, :bio, :password, :password_confirmation)
    end

    def update_params
      if current_user.is_admin?
        params.require(:user)
          .permit(:name, :email, :bio, :password, :password_confirmation, :approved, :access_level)
      elsif current_user.is_moderator?
        params.require(:user)
          .permit(:name, :email, :bio, :password, :password_confirmation, :approved)
      else
        params.require(:user)
          .permit(:name, :email, :bio, :password, :password_confirmation)
      end
    end

    def load_user
      @user ||= User.find_by(id: params[:id])
    end

    def user_policy(params: nil)
      UserPolicy.new(
        user: @user || nil,
        params: params
      )
    end
  end
end
