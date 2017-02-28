require 'rails_helper'

RSpec.describe MatchingPair, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:matching_pair)).to be_valid
  end

  it 'is invalid without a question' do
    expect(FactoryGirl.build(:matching_pair, question: nil)).not_to be_valid
  end

  it 'is invalid without an item 1' do
    expect(FactoryGirl.build(:matching_pair, item1: nil)).not_to be_valid
  end

  it 'is invalid with an item1 over 64 characters' do
    expect(FactoryGirl.build(:matching_pair, item1: 'a' * 65)).not_to be_valid
  end

  it 'is invalid without an item 2' do
    expect(FactoryGirl.build(:matching_pair, item2: nil)).not_to be_valid
  end

  it 'is invalid with an item2 over 64 characters' do
    expect(FactoryGirl.build(:matching_pair, item2: 'a' * 65)).not_to be_valid
  end

  it 'is invalid with a duplicate item1 and question' do
    matching_pair = FactoryGirl.create(:matching_pair)
    expect(FactoryGirl.build(:matching_pair, item1: matching_pair.item1, question: matching_pair.question)).not_to be_valid
  end

  it 'is invalid with a duplicate item2 and question' do
    matching_pair = FactoryGirl.create(:matching_pair)
    expect(FactoryGirl.build(:matching_pair, item2: matching_pair.item2, question: matching_pair.question)).not_to be_valid
  end
end
