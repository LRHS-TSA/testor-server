require 'rails_helper'

RSpec.describe MatchingPairAnswer, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:matching_pair_answer)).to be_valid
  end

  it 'is invalid without a question' do
    expect(FactoryGirl.build(:matching_pair_answer, question: nil)).not_to be_valid
  end

  it 'is invalid without a session' do
    expect(FactoryGirl.build(:matching_pair_answer, session: nil)).not_to be_valid
  end

  it 'is invalid without an item1' do
    expect(FactoryGirl.build(:matching_pair_answer, item1: nil)).not_to be_valid
  end

  it 'is invalid without an item2' do
    expect(FactoryGirl.build(:matching_pair_answer, item2: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate item1 and session' do
    matching_pair_answer = FactoryGirl.create(:matching_pair_answer)
    expect(FactoryGirl.build(:matching_pair_answer, item1: matching_pair_answer.item1, session: matching_pair_answer.session)).not_to be_valid
  end

  it 'is invalid with a duplicate item2 and session' do
    matching_pair_answer = FactoryGirl.create(:matching_pair_answer)
    expect(FactoryGirl.build(:matching_pair_answer, item2: matching_pair_answer.item2, session: matching_pair_answer.session)).not_to be_valid
  end
end
