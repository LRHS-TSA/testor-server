require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  it 'is invalid without a test' do
    expect(FactoryGirl.build(:question, test: nil)).not_to be_valid
  end

  it 'is invalid without text' do
    expect(FactoryGirl.build(:question, text: nil)).not_to be_valid
  end

  it 'is invalid with text over 4096 characters' do
    expect(FactoryGirl.build(:question, text: 'a' * 4097)).not_to be_valid
  end

  it 'is invalid without a type' do
    expect(FactoryGirl.build(:question, question_type: nil)).not_to be_valid
  end

  it 'is invalid without a point value' do
    expect(FactoryGirl.build(:question, points: nil)).not_to be_valid
  end

  it 'is invalid with a point value of 0' do
    expect(FactoryGirl.build(:question, points: 0)).not_to be_valid
  end

  it 'is invalid with a negative point value' do
    expect(FactoryGirl.build(:question, points: -1)).not_to be_valid
  end
end
