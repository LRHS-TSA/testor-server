require 'rails_helper'

RSpec.feature 'Questions' do
  login_teacher

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  context 'Creating a question', js: true do
    scenario 'with valid parameters' do
      visit test_questions_path(test)
      click_button 'Add Question'
      params = FactoryGirl.build(:question)
      within('#new_question') do
        fill_in 'Question', with: params.text
      end
      click_button 'Add'
      expect(page).to have_content(params.text)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      click_button 'Add Question'
      within('#new_question') do
      end
      click_button 'Add'
      expect(page).to have_content('Text')
    end
  end

  context 'Deleting a question', js: true do
    background do
      FactoryGirl.create(:question, test: test)
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      params = FactoryGirl.build(:question)
      click_button '×'
      expect(page).not_to have_content(params.text)
    end
  end

  context 'Editing a question', js: true do
    background do
      FactoryGirl.create(:question, test: test)
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      find('.d-inline.btn-success').click
      params = FactoryGirl.build(:question, text: 'edit')
      within('#editQuestion') do
        fill_in 'Question', with: params.text
        click_button 'Save'
      end
      expect(page).to have_content(params.text)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      find('.d-inline.btn-success').click
      params = FactoryGirl.build(:question, text: '')
      within('#editQuestion') do
        fill_in 'Question', with: params.text
        click_button 'Save'
      end
      expect(page).to have_content('error')
    end
  end
end
