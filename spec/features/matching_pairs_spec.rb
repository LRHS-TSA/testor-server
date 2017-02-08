require 'rails_helper'

RSpec.feature 'Matching Pair Options' do
  login_teacher

  context 'Creating a matching pair option', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    background do
      FactoryGirl.create(:question, test: test, question_type: 'matching')
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      params = FactoryGirl.build(:matching_pair)
      find('.collapse-btn').click
      within('.add_pair') do
        fill_in 'Item One', with: params.item1
        fill_in 'Item Two', with: params.item2
      end
      find('input[name="commit"]').click
      using_wait_time 3 do
        expect(page).to have_content(params.item1)
      end
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      find('.collapse-btn').click
      within('.add_pair') do
        fill_in 'Item One', with: nil
      end
      find('input[name="commit"]').click
      using_wait_time 3 do
        expect(page).to have_content('error')
      end
    end
  end

  context 'Editing a matching pair option', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    let(:question) do
      FactoryGirl.create(:question, test: test, question_type: 'matching')
    end

    background do
      FactoryGirl.create(:matching_pair, question: question)
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      find('.edit-pair-button').click
      params = FactoryGirl.build(:matching_pair, item1: 'edit')
      within('.edit_pair') do
        fill_in 'Item One', with: params.item1
        fill_in 'Item Two', with: params.item2
        click_button 'Save'
      end
      expect(page).to have_content(params.item1)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      find('.edit-pair-button').click
      params = FactoryGirl.build(:matching_pair, item1: '')
      within('.edit_pair') do
        fill_in 'Item One', with: params.item1
        fill_in 'Item Two', with: params.item2
        click_button 'Save'
      end
      expect(page).to have_content('error')
    end
  end

  context 'Deleting a matching pair option', js: true do
    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    let(:question) do
      FactoryGirl.create(:question, test: test, question_type: 'matching')
    end

    background do
      FactoryGirl.create(:matching_pair, question: question)
    end

    scenario 'with valid parameters' do
      visit test_questions_path(test)
      params = FactoryGirl.build(:matching_pair)
      find('input[value="×"].btn-sm').click
      expect(page).not_to have_content(params.item1)
    end
  end
end
