json.array! @groups do |group|
  json.id group.id
  json.name group.name
  json.description group.description
end
