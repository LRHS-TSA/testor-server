json.array! @multiple_choice_answers do |multiple_choice_answer|
  json.id multiple_choice_answer.id
  json.question_id multiple_choice_answer.question.id
  json.multiple_choice_option_id multiple_choice_answer.multiple_choice_option.id
end
