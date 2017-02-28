# Stores question metadata and text
class Question < ApplicationRecord
  belongs_to :test, inverse_of: :questions
  has_many :multiple_choice_options, inverse_of: :question
  has_many :matching_pairs, inverse_of: :question
  enum question_type: [:essay, :multiple_choice, :short_answer, :matching]

  has_one :text_answer
  has_one :multiple_choice_answer

  validates :test, presence: true
  validates :text, presence: true, length: {maximum: 4096}
  validates :question_type, presence: true
end
