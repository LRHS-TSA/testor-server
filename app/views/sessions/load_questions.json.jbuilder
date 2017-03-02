json.array! @session.assignment.test.questions do |question|
  json.id question.id
  json.text question.text
  json.question_type question.question_type
  json.points question.points
  if question.multiple_choice?
    json.multiple_choice_options question.multiple_choice_options.shuffle do |multiple_choice_option|
      json.id multiple_choice_option.id
      json.text multiple_choice_option.text
    end
  end
  if question.matching?
    json.item1s question.matching_pairs.collect(&:item1).shuffle
    json.item2s question.matching_pairs.collect(&:item2).shuffle
  end
end
