json.array! @scores do |score|
  json.id score.id
  json.question_id score.question.id
  json.score score.score
end
