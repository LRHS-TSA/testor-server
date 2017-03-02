json.array! @session.questions do |question|
  json.id question.id
  json.text question.text
  json.question_type question.question_type
  json.points question.points
  if question.multiple_choice?
    json.array! question.multiple_choice_options do |multiple_choice_option|
      json.id multiple_choice_option.id
      json.text multiple_choice_option.text
    end
  end
  if question.matching?
    json.item1s question.multiple_choice_options.collect(&:item1)
    json.item2s question.multiple_choice_options.collect(&:item2)
  end
end
