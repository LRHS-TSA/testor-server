# Stores a pair answer for matching questions
class MatchingPairAnswer < ApplicationRecord
  belongs_to :question, inverse_of: :matching_pair_answers
  belongs_to :session, inverse_of: :matching_pair_answers

  validates :question, presence: true
  validates :session, presence: true
  validates :item1, presence: true
  validates :item2, presence: true
  validates :item1, uniqueness: {scope: :session}
  validates :item2, uniqueness: {scope: :session}
end
