# Stores question metadata and text
class Question < ApplicationRecord
  belongs_to :test, inverse_of: :questions
  has_many :multiple_choice_options, inverse_of: :question
  has_many :matching_pairs, inverse_of: :question
  enum question_type: [:essay, :multiple_choice, :short_answer, :matching]

  has_many :text_answers
  has_many :multiple_choice_answers
  has_many :matching_pair_answers
  has_many :scores

  validates :test, presence: true
  validates :text, presence: true, length: {maximum: 4096}
  validates :question_type, presence: true
  validates :points, presence: true, numericality: {greater_than: 0}
end
