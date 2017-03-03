# Stores data for test sessions
class Session < ApplicationRecord
  belongs_to :assignment, inverse_of: :sessions
  belongs_to :user, inverse_of: :sessions
  enum status: [:awaiting_approval, :approved, :used]

  has_many :text_answers
  has_many :multiple_choice_answers
  has_many :matching_pair_answers
  has_many :scores

  validates :assignment, presence: true
  validates :user, presence: true
  validates :user, uniqueness: {scope: :assignment}
  validates :status, presence: true

  def locked?
    !assignment.start_date.nil? && assignment.start_date.utc > Time.now.utc || !assignment.end_date.nil? && assignment.end_date.utc < Time.now.utc || !assignment.length.nil? && !start_time.nil? && assignment.length.seconds.ago > start_time
  end

  def grade_multiple_choice
    assignment.test.questions.where(question_type: :multiple_choice).find_each do |question|
      next unless Score.find_by(session: self, question: question).nil?
      answer = question.multiple_choice_answers.find_by(session: self)
      if answer.nil? || !answer.multiple_choice_option.correct
        Score.create(session: self, question: question, score: 0)
      else
        Score.create(session: self, question: question, score: question.points)
      end
    end
  end

  def grade_matching
    assignment.test.questions.where(question_type: :matching).find_each do |question|
      next unless Score.find_by(session: self, question: question).nil?
      answers = question.matching_pair_answers.where(session: self)
      correct_count = 0
      answers.find_each do |answer|
        correct_count += 1 unless question.matching_pairs.find_by(item1: answer.item1, item2: answer.item2).nil?
      end
      if correct_count == question.matching_pairs.length
        Score.create(session: self, question: question, score: question.points)
      else
        Score.create(session: self, question: question, score: 0)
      end
    end
  end
end
