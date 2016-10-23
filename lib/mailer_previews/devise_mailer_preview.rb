# Previews mail sent by devise
class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(name: 'Test Man', email: 'dawjawd@test.com', role: 1, password: 'test1234', password_confirmation: 'test1234')
    Devise::Mailer.confirmation_instructions(user, 'dawhjiuoawdsiojklawdjikoadwoijijoadw')
  end
end
