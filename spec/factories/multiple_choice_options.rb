FactoryGirl.define do
  factory :multiple_choice_option do
    association :question, question_type: :multiple_choice
    sequence(:text) { |n| "Option #{n}" }
    correct false
  end
end
