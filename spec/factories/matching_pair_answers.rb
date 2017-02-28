FactoryGirl.define do
  factory :matching_pair_answer do
    association :question, question_type: :matching
    association :session
    sequence(:item1) { |n| "Item 1-#{n}" }
    sequence(:item2) { |n| "Item 2-#{n}" }
  end
end
