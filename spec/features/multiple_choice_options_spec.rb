require 'rails_helper'

RSpec.feature 'Multiple Choice Options' do
  login_teacher

  context 'Creating a multiple choice option', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    background do
      FactoryGirl.create(:question, test: test, question_type: 'multiple_choice')
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      params = FactoryGirl.build(:multiple_choice_option)
      find('.collapse-btn').click
      within('.add_option') do
        fill_in 'Text', with: params.text
      end
      find('input[name="commit"]').click
      using_wait_time 3 do
        expect(page).to have_content(params.text)
      end
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      find('.collapse-btn').click
      within('.add_option') do
        find('.form-check-inline').set(true)
      end
      find('input[name="commit"]').click
      using_wait_time 3 do
        expect(page).to have_content('error')
      end
    end
  end

  context 'Deleting a multiple choice option', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    let(:question) do
      FactoryGirl.create(:question, test: test, question_type: 'multiple_choice')
    end

    background do
      FactoryGirl.create(:multiple_choice_option, question: question)
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      params = FactoryGirl.build(:multiple_choice_option)
      find('.delete-multiple-choice-option').click
      expect(page).not_to have_content(params.text)
    end
  end

  context 'Editing a multiple choice option', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    let(:question) do
      FactoryGirl.create(:question, test: test, question_type: 'multiple_choice')
    end

    background do
      FactoryGirl.create(:multiple_choice_option, question: question)
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      find('.btn-success.btn-sm').click
      params = FactoryGirl.build(:multiple_choice_option)
      within('.edit_option') do
        fill_in 'Text', with: params.text
        click_button 'Save'
      end
      expect(page).to have_content(params.text)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      find('.btn-success.btn-sm').click
      params = FactoryGirl.build(:multiple_choice_option, text: '')
      within('.edit_option') do
        fill_in 'Text', with: params.text
        click_button 'Save'
      end
      expect(page).to have_content('error')
    end
  end
end
