# Assigning a test to a class
class Assignment < ApplicationRecord
  belongs_to :group, inverse_of: :assignments
  belongs_to :test, inverse_of: :assignments

  has_many :sessions

  validates :group, presence: true
  validates :test, presence: true
  validates :name, presence: true

  delegate :points_possible, to: :test

  def length=(value)
    if value.nil? || value[4].nil? && value[5].nil?
      self[:length] = nil
    else
      self[:length] = (value[4].nil? ? 0 : value[4]) * 60 + (value[5].nil? ? 0 : value[5])
    end
  end
end
