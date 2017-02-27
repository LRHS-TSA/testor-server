FactoryGirl.define do
  factory :session do
    association :assignment
    association :user
    status :approved
  end
end
