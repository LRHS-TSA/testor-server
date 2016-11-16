# Stores question metadata and text
class Question < ApplicationRecord
  belongs_to :test, inverse_of: :questions
  has_many :options, inverse_of: :question
  enum question_type: [:essay, :multiple_choice, :short_answer]

  validates :test, presence: true
  validates :text, presence: true, length: {maximum: 4096}
  validates :question_type, presence: true
end
