class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :amount, :user_id
  has_one :category
end
