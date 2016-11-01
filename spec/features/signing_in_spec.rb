require 'rails_helper'

RSpec.feature 'Signing in' do
  let(:user) do
    FactoryGirl.create(:user)
  end

  scenario 'with valid credentials' do
    user.confirm
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'with invalid credentials' do
    visit '/users/sign_in'
    click_button 'Sign in'
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'to an unconfirmed user' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Sign in'
    expect(page).to have_content('You have to confirm your email address before continuing.')
  end
end
