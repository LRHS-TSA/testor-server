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
      within('.add_option') do
        fill_in 'Text', with: params.text
      end
      click_button 'Add'
      expect(page).to have_content(params.text)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      click_button 'Add'
      expect(page).to have_content('error')
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
      click_button('×')
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
      find('.fa-pencil-square-o').click
      params = FactoryGirl.build(:multiple_choice_option)
      within('.edit_option') do
        fill_in 'Text', with: params.text
        click_button 'Save'
      end
      expect(page).to have_content(params.text)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      find('.fa-pencil-square-o').click
      params = FactoryGirl.build(:multiple_choice_option, text: '')
      within('.edit_option') do
        fill_in 'Text', with: params.text
        click_button 'Save'
      end
      expect(page).to have_content('error')
    end
  end
end
