FactoryGirl.define do
  factory :user do
    name FFaker::Name.first_name
    sequence(:email) { |n| "user#{n}@example.com" }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end
end
