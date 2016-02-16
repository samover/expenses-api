class User < ActiveRecord::Base
  has_many :expenses
  validates :email, presence: true, uniqueness: true, format: { :with => /@/ }
  validates :password, presence: true, confirmation: true
end
