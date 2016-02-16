FactoryGirl.define do
  factory :user do
    email { FFaker::Internet::email } 
    password "password"
    password_confirmation "password"
    auth_token "b934mdk3948"
  end
end
