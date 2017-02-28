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

    let(:group) do
      FactoryGirl.create(:member, user: user).group
    end

    let(:assignment) do
      FactoryGirl.create(:assignment, group: group)
    end

    let(:test) do
      FactoryGirl.create(:test, user: user)
    end

    let(:question) do
      FactoryGirl.create(:question, test: test)
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

    it 'can manage assignments for groups they are in' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:assignment, group: group))
    end

    it 'cannot manage assignments for groups they are not in' do
      is_expected.not_to be_able_to(:manage, Assignment.new)
    end

    it 'can manage questions for tests they own' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:question, test: test))
    end

    it 'cannot manage questions for tests they do not own' do
      is_expected.not_to be_able_to(:manage, Question.new)
    end

    it 'can manage multiple choice options for questions in tests they own' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:multiple_choice_option, question: question))
    end

    it 'cannot manage multiple choice options for questions in tests they do not own' do
      is_expected.not_to be_able_to(:manage, MultipleChoiceOption.new)
    end

    it 'can manage matching pairs for questions in tests they own' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:matching_pair, question: question))
    end

    it 'cannot manage matching pairs for questions in tests they do not own' do
      is_expected.not_to be_able_to(:manage, MatchingPair.new)
    end

    it 'can manage sessions for their group' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:session, assignment: assignment))
    end

    it 'cannot manage sessions for other groups' do
      is_expected.not_to be_able_to(:manage, FactoryGirl.create(:session))
    end

    it 'can read text answers for their questions' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:text_answer, question: question))
    end

    it 'cannot read text answers for other questions' do
      is_expected.not_to be_able_to(:read, TextAnswer.new)
    end

    it 'can read multiple choice answers for their questions' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:multiple_choice_answer, question: question))
    end

    it 'cannot read multiple choice answers for other questions' do
      is_expected.not_to be_able_to(:read, MultipleChoiceAnswer.new)
    end

    it 'can read matching pair answers for their questions' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:matching_pair_answer, question: question))
    end

    it 'cannot read matching pair answers for other questions' do
      is_expected.not_to be_able_to(:read, MatchingPairAnswer.new)
    end

    it 'can manage scores for their questions' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:score, question: question))
    end

    it 'cannot manage scores for other questions' do
      is_expected.not_to be_able_to(:manage, Score.new)
    end
  end

  context 'as a student' do
    let(:user) do
      FactoryGirl.create(:user, role: 0)
    end

    let(:group) do
      FactoryGirl.create(:member, user: user).group
    end

    let(:assignment) do
      FactoryGirl.create(:assignment, group: group)
    end

    let(:session) do
      FactoryGirl.create(:session, assignment: assignment, user: user)
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

    it 'can read assignments for groups they are in' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:assignment, group: group))
    end

    it 'cannot read assignments for groups they are not in' do
      is_expected.not_to be_able_to(:read, Assignment.new)
    end

    it 'can create sessions for assignments for their group' do
      is_expected.to be_able_to(:create, FactoryGirl.create(:session, assignment: assignment))
    end

    it 'cannot create sessions for assignments for other groups' do
      is_expected.not_to be_able_to(:create, FactoryGirl.create(:session))
    end

    it 'can read their sessions' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:session, assignment: assignment, user: user))
    end

    it 'cannot read sessions for other users' do
      is_expected.not_to be_able_to(:read, FactoryGirl.create(:session, assignment: assignment))
    end

    it 'can update their sessions' do
      is_expected.to be_able_to(:update, FactoryGirl.create(:session, assignment: assignment, user: user))
    end

    it 'cannot update sessions for other users' do
      is_expected.not_to be_able_to(:update, FactoryGirl.create(:session, assignment: assignment))
    end

    it 'can manage multiple choice answers for their sessions' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:multiple_choice_answer, session: session))
    end

    it 'cannot manage multiple choice answers for other sessions' do
      is_expected.not_to be_able_to(:manage, MultipleChoiceAnswer.new)
    end

    it 'can manage matching pair answers for their sessions' do
      is_expected.to be_able_to(:manage, FactoryGirl.create(:matching_pair_answer, session: session))
    end

    it 'cannot manage matching pair answers for other sessions' do
      is_expected.not_to be_able_to(:manage, MatchingPairAnswer.new)
    end

    it 'can read scores for their sessions' do
      is_expected.to be_able_to(:read, FactoryGirl.create(:score, session: session))
    end

    it 'cannot read scores for other sessions' do
      is_expected.not_to be_able_to(:read, Score.new)
    end
  end
end
