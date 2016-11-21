FactoryGirl.define do
  factory :matching_pair do
    association :question
    sequence(:item1) { |n| "Item 1-#{n}" }
    sequence(:item2) { |n| "Item 2-#{n}" }
  end
end
