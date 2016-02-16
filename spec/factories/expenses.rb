FactoryGirl.define do
  factory :expense do
    date Date.parse("14/02/2016") 
    title { FFaker::Lorem::phrase }
    amount { (rand * 100).round(2) }
    user nil
    category nil
  end
end
