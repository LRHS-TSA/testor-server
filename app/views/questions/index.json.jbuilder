json.array! @questions do |question|
  json.id question.id
  json.text question.text
  json.question_type question.question_type
  json.points question.points
end
