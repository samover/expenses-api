class Api::V1::SessionsController < ApplicationController

  before_filter :authenticate_user_from_token, except: [:create]

  def create
    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user && user.password == password
        render json: user, status: 200
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

  def destroy
    authenticate_with_http_token do |token, options|
      user = User.find_by(auth_token: token)
      user.auth_token = SecureRandom.hex 
      user.save
      head 204
    end
  end
end
