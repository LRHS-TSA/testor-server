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
      within('.add_pair') do
        fill_in 'Item One', with: params.item1
        fill_in 'Item Two', with: params.item2
      end
      click_button 'Add'
      expect(page).to have_content(params.item1)
    end

    scenario 'with invalid parameters' do
      visit test_questions_path(test)
      click_button 'Add'
      expect(page).to have_content('error')
    end
  end
end
