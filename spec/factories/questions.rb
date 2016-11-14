FactoryGirl.define do
  factory :question do
    association :test
    sequence(:text) { |n| "What is the answer to question #{n}?" }
    type :essay
  end
end
