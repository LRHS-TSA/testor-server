json.user @session.user
json.status @session.status
json.start_time @session.start_time
json.points_earned @session.scores.sum(:score)
json.points_possible @session.assignment.test.questions.sum(:points)
