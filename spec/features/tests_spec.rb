require 'rails_helper'

RSpec.feature 'Tests' do
  login_teacher

  context 'Creating a test', js: true do
    scenario 'with valid parameters' do
      visit new_test_path
      params = FactoryGirl.build(:test)
      within('#new_test') do
        fill_in 'Name', with: params.name
      end
      click_button 'Create'
      expect(page).to have_content(params.name)
    end

    scenario 'with invalid parameters' do
      visit new_test_path
      click_button 'Create'
      expect(page).to have_content('error')
    end
  end

  context 'Editing a test', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    scenario 'with valid parameters' do
      visit edit_test_path(test)
      params = FactoryGirl.build(:test)
      within("#edit_test_#{test.id}") do
        fill_in 'Name', with: params.name
      end
      click_button 'Update'
      expect(page).to have_content(params.name)
    end

    scenario 'with invalid parameters' do
      visit edit_test_path(test)
      within("#edit_test_#{test.id}") do
        fill_in 'Name', with: ''
      end
      click_button 'Update'
      expect(page).to have_content('error')
    end
  end
end
