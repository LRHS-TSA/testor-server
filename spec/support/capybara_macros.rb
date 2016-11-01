# Macros to make capybara with devise easier
module CapybaraMacros
  def login_student
    given(:user) do
      FactoryGirl.create(:user, role: 0, name: 'student')
    end

    background do
      user.confirm
      login_as(user, scope: :user)
    end
  end

  def login_teacher
    given(:user) do
      FactoryGirl.create(:user, role: 1, name: 'teacher')
    end

    background do
      user.confirm
      login_as(user, scope: :user)
    end
  end
end
