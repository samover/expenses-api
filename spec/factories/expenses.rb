FactoryGirl.define do
  factory :expense do
    date "2016-02-16"
    title "MyString"
    amount 1.5
    user nil
    category nil
  end
end
