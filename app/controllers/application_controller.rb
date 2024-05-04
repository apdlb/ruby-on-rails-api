class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorized

  def authorized
    # Renders an error if the session doesn't include a :user_id key
    if cookies.key? :user_id
      @me = User.find(cookies.encrypted[:user_id])
    else
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end
end
