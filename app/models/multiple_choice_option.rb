# Stores options for multiple choice questions
class MultipleChoiceOption < ApplicationRecord
  belongs_to :question, inverse_of: :multiple_choice_options

  validates :question, presence: true
  validates :text, presence: true, length: {maximum: 64}
  validates :correct, inclusion: [true, false]
end
