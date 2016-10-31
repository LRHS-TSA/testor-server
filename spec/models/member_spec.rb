require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryGirl.build(:member)).to be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryGirl.build(:member, user_id: nil)).not_to be_valid
  end

  it 'is invalid without a group' do
    expect(FactoryGirl.build(:member, group_id: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate a user' do
    member = FactoryGirl.create(:member)
    expect(FactoryGirl.build(:member, user: member.user, group: member.group)).not_to be_valid
  end
end
