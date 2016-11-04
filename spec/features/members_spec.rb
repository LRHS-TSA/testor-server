require 'rails_helper'

RSpec.feature 'Members' do
  context 'Joining a group', js: true do
    let(:group) do
      FactoryGirl.create(:group)
    end

    context 'as a student' do
      login_student

      scenario 'with valid parameters' do
        visit root_path
        click_link('addGroupDropdown')
        within('#navbar_add_group') do
          fill_in 'Token', with: group.student_token
        end
        click_button 'Join Group'
        expect(page).to have_content(group.name)
      end
    end

    context 'as a teacher' do
      login_teacher

      scenario 'with valid parameters' do
        visit root_path
        click_link('addGroupDropdown')
        within('#navbar_add_group') do
          fill_in 'Token', with: group.teacher_token
        end
        click_button 'Join Group'
        expect(page).to have_content(group.name)
      end
    end
  end
end
