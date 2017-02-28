# Stores text answers for essay and short answer questions
class TextAnswer < ApplicationRecord
  belongs_to :question, inverse_of: :text_answers
  belongs_to :session, inverse_of: :text_answers

  validates :question, presence: true
  validates :session, presence: true
  validates :question, uniqueness: {scope: :session}
  validates :text, presence: true
end
