require 'rails_helper'

RSpec.feature 'Groups' do
  login_teacher

  context 'Creating a group', js: true do
    scenario 'with valid parameters' do
      visit '/groups/new'
      within('#new_group') do
        fill_in 'Name', with: FFaker::Education.school_name
        fill_in 'Description', with: FFaker::Lorem.paragraph
      end
      click_button 'Create'
      expect(current_path).to eq(group_path(Group.last))
    end

    scenario 'with invalid parameters' do
      visit '/groups/new'
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
      within("#edit_group_#{group.id}") do
        fill_in 'Name', with: ' ' + FFaker::Education.school_name
        fill_in 'Description', with: ' ' + FFaker::Lorem.paragraph
      end
      click_button 'Update'
      expect(current_path).to eq(group_path(Group.last))
    end

    scenario 'with invalid parameters' do
      visit edit_group_path(group)
      within("#edit_group_#{group.id}") do
        fill_in 'Name', with: ''
        fill_in 'Description', with: ''
      end
      click_button 'Create'
      expect(page).to have_content('error')
    end
  end
end
