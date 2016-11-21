require 'rails_helper'

RSpec.describe MultipleChoiceOption, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:multiple_choice_option)).to be_valid
  end

  it 'is invalid without a question' do
    expect(FactoryGirl.build(:multiple_choice_option, question: nil)).not_to be_valid
  end

  it 'is invalid without text' do
    expect(FactoryGirl.build(:multiple_choice_option, text: nil)).not_to be_valid
  end

  it 'is invalid with text over 64 characters' do
    expect(FactoryGirl.build(:multiple_choice_option, text: 'a' * 65)).not_to be_valid
  end

  it 'is invalid without correctness' do
    expect(FactoryGirl.build(:multiple_choice_option, correct: nil)).not_to be_valid
  end
end
