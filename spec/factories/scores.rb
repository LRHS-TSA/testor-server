FactoryGirl.define do
  factory :score do
    association :session
    association :question
    score 0
  end
end
