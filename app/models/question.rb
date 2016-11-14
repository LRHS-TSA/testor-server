# Stores question metadata and text
class Question < ApplicationRecord
  belongs_to :test, inverse_of: :questions
  enum type: [:essay, :multiple_choice, :short_answer]

  validates :test, presence: true
  validates :text, presence: true, length: {maximum: 4096}
  validates :type, presence: true
end
