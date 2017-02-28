FactoryGirl.define do
  factory :question do
    association :test
    sequence(:text) { |n| "What is the answer to question #{n}?" }
    question_type :essay
    points { (Kernel.rand * 10).floor + 1 }
  end
end
