FactoryGirl.define do
  factory :test do
    sequence(:name) { |n| "Test #{n}" }
    association :user
  end
end
