class User < ActiveRecord::Base
  before_create :generate_authentcation_token 

  has_many :expenses
  validates :email, presence: true, uniqueness: true, format: { :with => /@/ }
  validates :password, presence: true, confirmation: true

  def generate_authentcation_token 
    begin
      self.auth_token = SecureRandom.hex 
    end while self.class.exists?(auth_token: auth_token)
  end
end
