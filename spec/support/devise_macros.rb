# Macros to make rspec with devise easier
module DeviseMacros
  def login_student
    before do
      user = FactoryGirl.create(:user, role: 0, name: 'student')
      user.confirm
      sign_in user
    end
  end

  def login_teacher
    before do
      user = FactoryGirl.create(:user, role: 1, name: 'teacher')
      user.confirm
      sign_in user
    end
  end
end
