FactoryGirl.define do
  factory :member do
    association :group
    association :user
  end
end
