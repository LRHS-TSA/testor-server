# Stores answers for multiple choice questions
class MultipleChoiceAnswer < ApplicationRecord
  belongs_to :question, inverse_of: :multiple_choice_answers
  belongs_to :session, inverse_of: :multiple_choice_answers
  belongs_to :multiple_choice_option, inverse_of: :multiple_choice_answer

  validates :question, presence: true
  validates :session, presence: true
  validates :question, uniqueness: {scope: :session}
  validates :multiple_choice_option, presence: true
end
