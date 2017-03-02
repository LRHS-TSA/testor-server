json.array! @assignments do |assignment|
  json.id assignment.id
  json.name assignment.name
  json.test_id assignment.test_id
  json.start_date assignment.start_date
  json.end_date assignment.end_date
  json.length assignment.length
end
