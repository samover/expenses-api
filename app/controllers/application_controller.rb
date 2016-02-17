class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_filter :authenticate_user_from_token, except: [:sign_in]

  def sign_in
    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user && user.password == password
        render json: { token: user.auth_token }, status: 200
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

  def sign_out
    authenticate_with_http_token do |token, options|
      user = User.find_by(auth_token: token)
      user.auth_token = SecureRandom.hex 
      user.save
      head 204
    end
  end

  private

  def authenticate_user_from_token
    unless logged_in?
      render json: { error: 'Bad token' }, status: 401
    end
  end

  def logged_in?
    authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
  end
end
