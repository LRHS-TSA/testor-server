# Tests teachers can assign to students for a grade
class Test < ApplicationRecord
  belongs_to :user, inverse_of: :tests
  has_many :assignments
  has_many :questions

  validates :name, presence: true, length: {minimum: 3, maximum: 32}
  validates :user, presence: true

  def points_possible
    questions.sum(:points)
  end
end
