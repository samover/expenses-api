class User < ActiveRecord::Base
  before_create -> { self.auth_token = SecureRandom.hex }

  has_many :expenses
  validates :email, presence: true, uniqueness: true, format: { :with => /@/ }
  validates :password, presence: true, confirmation: true
end
