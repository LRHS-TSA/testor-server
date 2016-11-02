json.name @group.name
json.description @group.description

if can? :manage, @group
  json.student_token @group.student_token
  json.teacher_token @group.teacher_token
end
