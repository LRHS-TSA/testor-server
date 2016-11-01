# References a user for a group
class Member < ApplicationRecord
  belongs_to :group, inverse_of: :members
  belongs_to :user, inverse_of: :members

  validates :group, presence: true

  validates :user, presence: true
  validates :user, uniqueness: {scope: :group}
end
