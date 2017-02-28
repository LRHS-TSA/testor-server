# Store pairs for matching questions
class MatchingPair < ApplicationRecord
  belongs_to :question, inverse_of: :matching_pairs

  validates :question, presence: true
  validates :item1, presence: true, length: {maximum: 64}, uniqueness: {scope: :question}
  validates :item2, presence: true, length: {maximum: 64}, uniqueness: {scope: :question}
end
