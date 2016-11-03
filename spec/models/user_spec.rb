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

    it 'can manage groups they are in' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:member, user: user).group)
    end

    it 'cannot manage groups they are not in' do
      is_expected.not_to be_able_to(:manage, Group.new)
    end

    it 'can manage members for groups they are in' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:member, user: user))
    end

    it 'cannot manage members for groups they are not in' do
      is_expected.not_to be_able_to(:manage, Member.new)
    end

    it 'can join groups' do
      is_expected.to be_able_to(:join_group, Member.new)
    end

    it 'can create tests' do
      is_expected.to be_able_to(:create, Test.new)
    end

    it 'can manage tests they own' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:test, user: user))
    end

    it 'cannot manage tests they do not own' do
      is_expected.not_to be_able_to(:manage, Test.new)
    end
  end

  context 'as a student' do
    let(:user) do
      FactoryGirl.create(:user, role: 0)
    end

    it 'can read groups they are in' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:member, user: user).group)
    end

    it 'cannot read groups they are not in' do
      is_expected.not_to be_able_to(:read, Group.new)
    end

    it 'can join groups' do
      is_expected.to be_able_to(:join_group, Member.new)
    end

    it 'can leave groups' do
      is_expected.to be_able_to(:destroy, FactoryGirl.create(:member, user: user))
    end

    it 'cannot kick others out of groups' do
      is_expected.not_to be_able_to(:destroy, Member.new)
    end
  end
end
