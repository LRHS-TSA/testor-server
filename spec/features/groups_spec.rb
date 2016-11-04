require 'rails_helper'

RSpec.feature 'Groups' do
  login_teacher

  context 'Creating a group', js: true do
    scenario 'with valid parameters' do
      visit new_group_path
      params = FactoryGirl.build(:group)
      within('#new_group') do
        fill_in 'Name', with: params.name
        fill_in 'Description', with: params.description
      end
      click_button 'Create'
      expect(page).to have_content(params.name)
    end

    scenario 'with invalid parameters' do
      visit new_group_path
      click_button 'Create'
      expect(page).to have_content('error')
    end
  end

  context 'Editing a group', js: true do
    let(:group) do
      FactoryGirl.create(:group)
    end

    background do
      FactoryGirl.create(:member, group: group, user: user)
    end

    scenario 'with valid parameters' do
      visit edit_group_path(group)
      params = FactoryGirl.build(:group)
      within("#edit_group_#{group.id}") do
        fill_in 'Name', with: params.name
        fill_in 'Description', with: params.description
      end
      click_button 'Update'
      expect(page).to have_content(params.name)
    end

    scenario 'with invalid parameters' do
      visit edit_group_path(group)
      within("#edit_group_#{group.id}") do
        fill_in 'Name', with: ''
        fill_in 'Description', with: ''
      end
      click_button 'Update'
      expect(page).to have_content('error')
    end

    scenario 'by resetting the tokens' do
      visit edit_group_path(group)
      click_button 'Reset'
      expect(page).to have_content(group.name)
    end
  end
end
