require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:session)).to be_valid
  end

  it 'is invalid without an assignment' do
    expect(FactoryGirl.build(:session, assignment: nil)).not_to be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryGirl.build(:session, user: nil)).not_to be_valid
  end

  it 'is invalid without a status' do
    expect(FactoryGirl.build(:session, status: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate assignment and user' do
    session = FactoryGirl.create(:session)
    expect(FactoryGirl.build(:session, user: session.user, assignment: session.assignment)).not_to be_valid
  end
end
