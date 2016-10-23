# User model (Using Devise)
class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  include DeviseTokenAuth::Concerns::User
end
