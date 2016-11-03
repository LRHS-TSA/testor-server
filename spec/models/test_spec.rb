require 'rails_helper'

RSpec.describe Test, type: :model do
  it 'is valid with valid information' do
    expect(FactoryGirl.build(:test)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:test), name: nil).not_to be_valid
  end

  it 'is invalid with a name under 3 character' do
    expect(FactoryGirl.build(:test), name: 'aa').not_to be_valid
  end

  it 'is invalid with a name over 32 characters' do
    expect(FactoryGirl.build(:test, name: 'a' * 33)).not_to be_valid
  end

  it 'is invalid wihout a user' do
    expect(FactoryGirl.build(:test), user: nil).not_to be_valid
  end
end
