require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:group)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:group, name: nil)).not_to be_valid
  end

  it 'is invalid without a description' do
    expect(FactoryGirl.build(:group, description: nil)).not_to be_valid
  end

  it 'is invalid with a name under 3 characters' do
    expect(FactoryGirl.build(:group, name: 'aa')).not_to be_valid
  end

  it 'is invalid with a name over 16 characters' do
    expect(FactoryGirl.build(:group, name: 'a' * 17)).not_to be_valid
  end

  it 'is invalid with a description over 2048 characters' do
    expect(FactoryGirl.build(:group, description: 'a' * 2049)).not_to be_valid
  end
end
