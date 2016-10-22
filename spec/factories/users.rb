FactoryGirl.define do
  factory :user do
    name FFaker::Name.first_name
    email { "#{name}@example.com" }
    password FFaker::Internet.password
    password_confirmation { password }
  end
end
