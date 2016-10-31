# User model (Using Devise)
class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :members
  has_many :groups, through: :members
end
