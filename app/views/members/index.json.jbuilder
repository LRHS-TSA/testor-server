json.array! @members do |member|
  json.id member.id
  json.user_id member.user.id
  json.role member.user.role
end
