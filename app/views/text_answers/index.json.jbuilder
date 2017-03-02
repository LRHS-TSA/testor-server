json.array! @text_answers do |text_answer|
  json.id text_answer.id
  json.question_id text_answer.question.id
  json.text text_answer.text
end
