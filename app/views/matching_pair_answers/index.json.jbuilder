json.array! @matching_pair_answers do |matching_pair_answer|
  json.id matching_pair_answer.id
  json.question_id matching_pair_answer.question.id
  json.item1 matching_pair_answer.item1
  json.item2 matching_pair_answer.item2
end
