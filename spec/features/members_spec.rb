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

  context 'kicking a student', js: true do
    login_teacher

    let(:group) do
      FactoryGirl.create(:group)
    end

    let(:other_user) do
      FactoryGirl.create(:user, name: 'Test User')
    end

    background do
      FactoryGirl.create(:member, group: group, user: user)
      FactoryGirl.create(:member, group: group, user: other_user)
    end

    scenario 'with valid parameters' do
      visit group_members_path(group)
      last_member = group.members.last
      click_button('kick_' + last_member.id.to_s)
      visit group_members_path(group)
      expect(page).to have_no_content(last_member.user.name)
    end
  end
end
