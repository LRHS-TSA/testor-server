require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  subject(:ability) do
    Ability.new(user)
  end

  let(:user) do
    nil
  end

  context 'as a teacher' do
    let(:user) do
      FactoryGirl.create(:user, role: 1)
    end

    it 'can create groups' do
      is_expected.to be_able_to(:create, Group.new)
    end

    it 'can read groups they are in' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:member, user: user).group)
    end

    it 'cannot read groups they are not in' do
      is_expected.not_to be_able_to(:read, Group.new)
    end

    it 'can manage groups they are in' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:member, user: user).group)
    end

    it 'cannot manage groups they are not in' do
      is_expected.not_to be_able_to(:manage, Group.new)
    end
  end

  context 'as a student' do
    let(:user) do
      FactoryGirl.create(:user, role: 0)
    end

    it 'can read groups' do
      is_expected.to be_able_to(:read, Group.new)
    end
  end
end
