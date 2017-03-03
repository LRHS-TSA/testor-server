# Job used for automatically grading sessions
class GradeSessionJob < ApplicationJob
  queue_as :default

  def perform(session)
    session.grade_multiple_choice
    session.grade_matching
  end
end
