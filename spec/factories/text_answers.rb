FactoryGirl.define do
  factory :text_answer do
    association :question, question_type: :essay
    association :session
    sequence(:text) { |n| "Text Answer #{n}" }
  end
end
