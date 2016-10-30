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

    it 'can read groups' do
      is_expected.to be_able_to(:read, Group.new)
    end

    it 'can create groups' do
      is_expected.to be_able_to(:create, Group.new)
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
