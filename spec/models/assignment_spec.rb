require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:assignment)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:assignment, name: nil)).not_to be_valid
  end

  it 'is invalid without a group' do
    expect(FactoryGirl.build(:assignment, group: nil)).not_to be_valid
  end

  it 'is invalid without a test' do
    expect(FactoryGirl.build(:assignment, test: nil)).not_to be_valid
  end
end
