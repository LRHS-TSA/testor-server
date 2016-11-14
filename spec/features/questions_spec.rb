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
      click_button 'Delete'
      expect(page).not_to have_content(params.text)
    end
  end
end