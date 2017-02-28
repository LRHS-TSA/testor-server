require 'rails_helper'

RSpec.describe MultipleChoiceAnswer, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:multiple_choice_answer)).to be_valid
  end

  it 'is invalid without a question' do
    expect(FactoryGirl.build(:multiple_choice_answer, question: nil)).not_to be_valid
  end

  it 'is invalid without a session' do
    expect(FactoryGirl.build(:multiple_choice_answer, session: nil)).not_to be_valid
  end

  it 'is invalid without a multiple choice option' do
    expect(FactoryGirl.build(:multiple_choice_answer, multiple_choice_option: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate question and session' do
    text_answer = FactoryGirl.create(:multiple_choice_answer)
    expect(FactoryGirl.build(:multiple_choice_answer, question: text_answer.question, session: text_answer.session)).not_to be_valid
  end
end
