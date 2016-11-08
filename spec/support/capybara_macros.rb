# Macros to make capybara with devise easier
module CapybaraMacros
  def login_teacher
    given(:user) do
      FactoryGirl.create(:user, role: 1)
    end

    background do
      user.confirm
      login_as(user, scope: :user)
    end
  end

  def login_student
    given(:user) do
      FactoryGirl.create(:user, role: 0)
    end

    background do
      user.confirm
      login_as(user, scope: :user)
    end
  end
end
