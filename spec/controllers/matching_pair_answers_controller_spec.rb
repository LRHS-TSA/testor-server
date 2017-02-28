require 'rails_helper'

RSpec.describe MatchingPairAnswersController, type: :controller do
  login_student

  let(:group) do
    FactoryGirl.create(:member, user: user).group
  end

  let(:assignment) do
    FactoryGirl.create(:assignment, group: group, test: test)
  end

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:session) do
    FactoryGirl.create(:session, assignment: assignment, user: user)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test, question_type: :matching)
  end

  let(:invalid_type_question) do
    FactoryGirl.create(:question, test: test, question_type: :essay)
  end

  let(:invalid_question) do
    FactoryGirl.create(:question, question_type: :matching)
  end

  let(:matching_pair) do
    FactoryGirl.create(:matching_pair, question: question)
  end

  let(:update_matching_pair) do
    FactoryGirl.create(:matching_pair, question: question)
  end

  let(:matching_pair_answer) do
    FactoryGirl.create(:matching_pair_answer, session: session, question: question, item1: matching_pair.item1, item2: matching_pair.item2)
  end

  let(:valid_create_params) do
    {question_id: question.id, item1: matching_pair.item1, item2: matching_pair.item2}
  end

  let(:invalid_create_params) do
    {question_id: question.id, item1: nil, item2: nil}
  end

  let(:invalid_question_type_create_params) do
    {question_id: invalid_type_question.id, item1: nil, item2: nil}
  end

  let(:invalid_question_create_params) do
    {question_id: invalid_question.id, item1: nil, item2: nil}
  end

  let(:valid_update_params) do
    {item2: update_matching_pair.item2}
  end

  let(:invalid_update_params) do
    {item2: nil}
  end

  describe '#index' do
    before do
      get :index, params: {group_id: matching_pair_answer.session.assignment.group.id, assignment_id: matching_pair_answer.session.assignment.id, session_id: matching_pair_answer.session.id}
    end

    it 'assigns all matching pair answers as @matching_pair_answers' do
      expect(assigns[:matching_pair_answers]).to eq([matching_pair_answer])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {group_id: matching_pair_answer.session.assignment.group.id, assignment_id: matching_pair_answer.session.assignment.id, session_id: matching_pair_answer.session.id, id: matching_pair_answer.id}
    end

    it 'assigns the requested matching pair answer as @matching_pair_answer' do
      expect(assigns[:matching_pair_answer]).to eq(matching_pair_answer)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new matching pair answer' do
        expect { post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, matching_pair_answer: valid_create_params} }.to change(MatchingPairAnswer, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, matching_pair_answer: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, matching_pair_answer: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid question type' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, matching_pair_answer: invalid_question_type_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid question' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, matching_pair_answer: invalid_question_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {group_id: matching_pair_answer.session.assignment.group.id, assignment_id: matching_pair_answer.session.assignment.id, session_id: matching_pair_answer.session.id, id: matching_pair_answer.id, matching_pair_answer: valid_update_params}
      end

      it 'updates the requested matching pair answer' do
        matching_pair_answer.reload
        expect(matching_pair_answer.updated_at).not_to eq(matching_pair_answer.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: matching_pair_answer.session.assignment.group.id, assignment_id: matching_pair_answer.session.assignment.id, session_id: matching_pair_answer.session.id, id: matching_pair_answer.id, matching_pair_answer: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
