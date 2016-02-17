class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def token
    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user && user.password == password
        render json: { token: user.auth_token }, status: 200
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end
end
