# Organizes students and teachers into groups
class Group < ApplicationRecord
  validates :name, presence: true, length: [minimum: 3, maximum: 16]
  validates :description, presence: true, length: [maximum: 2048]
end
