require 'rails_helper'

RSpec.describe TextAnswer, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:text_answer)).to be_valid
  end

  it 'is invalid without a question' do
    expect(FactoryGirl.build(:text_answer, question: nil)).not_to be_valid
  end

  it 'is invalid without a session' do
    expect(FactoryGirl.build(:text_answer, session: nil)).not_to be_valid
  end

  it 'is invalid without text' do
    expect(FactoryGirl.build(:text_answer, text: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate question and session' do
    text_answer = FactoryGirl.create(:text_answer)
    expect(FactoryGirl.build(:text_answer, question: text_answer.question, session: text_answer.session)).not_to be_valid
  end
end
