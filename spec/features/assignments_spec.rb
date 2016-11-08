require 'rails_helper'

RSpec.feature 'Assignments' do
  login_teacher

  context 'Creating an assignment', js: true do
    let(:group) do
      FactoryGirl.create(:group)
    end

    background do
      FactoryGirl.create(:member, group: group, user: user)
      FactoryGirl.create(:test, user: user)
    end

    scenario 'with valid parameters' do
      visit new_group_assignment_path(group)
      params = FactoryGirl.build(:assignment)
      within('#new_assignment') do
        fill_in 'Name', with: params.name
        select Test.first.name, from: 'assignment_test_id'
      end
      click_button 'Create'
      expect(page).to have_content(params.name)
    end

    scenario 'with invalid parameters' do
      visit new_group_assignment_path(group)
      click_button 'Create'
      expect(page).to have_content('error')
    end
  end

  context 'Editing an assignment', js: true do
    let(:assignment) do
      FactoryGirl.create(:assignment)
    end

    background do
      FactoryGirl.create(:member, group: assignment.group, user: user)
    end

    scenario 'with valid parameters' do
      visit edit_group_assignment_path(assignment.group.id, assignment.id)
      params = FactoryGirl.build(:assignment)
      within("#edit_assignment_#{assignment.id}") do
        fill_in 'Name', with: params.name
      end
      click_button 'Update'
      expect(page).to have_content(params.name)
    end

    scenario 'with invalid parameters' do
      visit edit_group_assignment_path(assignment.group.id, assignment.id)
      within("#edit_assignment_#{assignment.id}") do
        fill_in 'Name', with: ''
      end
      click_button 'Update'
      expect(page).to have_content('error')
    end
  end
end
