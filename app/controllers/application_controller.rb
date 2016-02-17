class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods


  def authenticate_user_from_token
    unless logged_in?
      render json: { error: 'Bad token' }, status: 401
    end
  end

  def logged_in?
    authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
  end
end
