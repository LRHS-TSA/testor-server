# Tests teachers can assign to students for a grade
class Test < ApplicationRecord
  belongs_to :user, inverse_of: :tests

  validates :name, presence: true, length: {minimum: 3, maximum: 32}

  validates :user, presence: true
end
