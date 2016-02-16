class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :amount, :date
end
