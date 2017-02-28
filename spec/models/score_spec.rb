require 'rails_helper'

RSpec.describe Score, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:score)).to be_valid
  end

  it 'is invalid without a question' do
    expect(FactoryGirl.build(:score, question: nil)).not_to be_valid
  end

  it 'is invalid without a session' do
    expect(FactoryGirl.build(:score, session: nil)).not_to be_valid
  end

  it 'is invalid without a score' do
    expect(FactoryGirl.build(:score, score: nil)).not_to be_valid
  end

  it 'is invalid with a negative score' do
    expect(FactoryGirl.build(:score, score: -1)).not_to be_valid
  end

  it 'is invalid with a duplicate question and session' do
    score = FactoryGirl.create(:score)
    expect(FactoryGirl.build(:score, question: score.question, session: score.session)).not_to be_valid
  end
end
