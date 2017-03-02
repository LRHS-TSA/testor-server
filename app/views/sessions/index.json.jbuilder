json.array! @sessions do |session|
  json.id session.id
  json.user session.user
  json.status session.status
end
