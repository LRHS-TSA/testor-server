# User model (Using Devise)
class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :members
  has_many :groups, through: :members

  def teacher?
    role == 1
  end

  def student?
    !teacher?
  end
end
