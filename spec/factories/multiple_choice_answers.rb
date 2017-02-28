FactoryGirl.define do
  factory :multiple_choice_answer do
    association :question, question_type: :multiple_choice
    association :session
    association :multiple_choice_option
  end
end
