# Assigning a test to a class
class Assignment < ApplicationRecord
  belongs_to :group, inverse_of: :assignments
  belongs_to :test, inverse_of: :assignments

  validates :group, presence: true
  validates :test, presence: true
  validates :name, presence: true
end
