# Macros to make rspec with devise easier
module DeviseMacros
  def login_student
    let(:user) do
      FactoryGirl.create(:user, role: 0)
    end

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user.confirm
      sign_in user
    end
  end

  def login_teacher
    let(:user) do
      FactoryGirl.create(:user, role: 1)
    end

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user.confirm
      sign_in user
    end
  end
end
