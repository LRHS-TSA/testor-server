require 'rails_helper'

RSpec.feature 'Signing up' do
  scenario 'with valid information' do
    visit '/users/sign_up'
    within('#new_user') do
      name = FFaker::Name.first_name
      fill_in 'Name', with: name
      fill_in 'Email', with: "#{name}@example.com"
      password = FFaker::Internet.password
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
    end
    click_button 'Sign up'
    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
  end

  scenario 'with invalid information' do
    visit '/users/sign_up'
    click_button 'Sign up'
    expect(page).to have_content('The following errors occured:')
  end
end
