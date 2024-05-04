class AuthController < ApplicationController
  skip_before_action :authorized

  # POST /auth
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      cookies.encrypted[:user_id] = { value: @user.id, httponly: true, secure: true, expires: 1.hour }
    end
  end
end
