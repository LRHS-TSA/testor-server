# Stores data for test sessions
class Session < ApplicationRecord
  belongs_to :assignment, inverse_of: :sessions
  belongs_to :user, inverse_of: :sessions
  enum status: [:awaiting_approval, :approved, :used]

  has_many :text_answers
  has_many :multiple_choice_answers
  has_many :matching_pair_answers
  has_many :scores

  validates :assignment, presence: true
  validates :user, presence: true
  validates :user, uniqueness: {scope: :assignment}
  validates :status, presence: true

  def locked?
    !assignment.start_date.nil? && assignment.start_date.utc > Time.now.utc || !assignment.end_date.nil? && assignment.end_date.utc < Time.now.utc || !assignment.length.nil? && !start_time.nil? && assignment.length.seconds.ago > start_time
  end
end
