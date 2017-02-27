# Stores data for test sessions
class Session < ApplicationRecord
  belongs_to :assignment, inverse_of: :sessions
  belongs_to :user, inverse_of: :sessions
  enum status: [:awaiting_approval, :approved, :used]

  validates :assignment, presence: true
  validates :user, presence: true
  validates :user, uniqueness: {scope: :assignment}
  validates :status, presence: true
end
