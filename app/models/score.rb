# Stores the score for each question in a session
# Questions without a score are not calculated into the grade
class Score < ApplicationRecord
  belongs_to :session, inverse_of: :scores
  belongs_to :question, inverse_of: :scores

  validates :question, presence: true
  validates :session, presence: true
  validates :question, uniqueness: {scope: :session}
  validates :score, presence: true, numericality: {greater_than_or_equal_to: 0}
end
