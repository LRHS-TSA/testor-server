# User model (Using Devise)
class User < ApplicationRecord
  acts_as_token_authenticatable
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :members
  has_many :groups, through: :members

  has_many :tests

  def teacher?
    role == 1
  end

  def student?
    !teacher?
  end
end
