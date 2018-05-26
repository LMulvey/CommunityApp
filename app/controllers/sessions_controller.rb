# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: auth_params[:email])
    if user.authenticate(auth_params[:password])
      jwt = Auth.issue({user: user.id})
      render(
        status: :ok,
        json: { jwt: jwt,
                user_id: user.id,
                user_email: user.email,
                user_name: user.name, }
      ) && return
    end
      render(
        status: :unauthorized,
        json: { error: 'Could not authorize. Double check username / password.' }
      ) && return
  end

  private

  def auth_params
    params.require(:user)
      .permit(:email, :password)
  end
end
