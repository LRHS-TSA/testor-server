require 'rails_helper'

RSpec.describe ScoresController, type: :controller do
  login_teacher

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
    FactoryGirl.create(:session, assignment: assignment)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test)
  end

  let(:score) do
    FactoryGirl.create(:score, session: session, question: question, score: 0)
  end

  let(:valid_create_params) do
    {question_id: question.id, score: question.points}
  end

  let(:invalid_create_params) do
    {question_id: question.id, score: nil}
  end

  let(:score_over_points_create_params) do
    {question_id: question.id, score: question.points + 1}
  end

  let(:valid_update_params) do
    {score: question.points}
  end

  let(:invalid_update_params) do
    {score: nil}
  end

  let(:score_over_points_update_params) do
    {score: question.points + 1}
  end

  describe '#index' do
    before do
      get :index, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id}
    end

    it 'assigns all scores as @scores' do
      expect(assigns[:scores]).to eq([score])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id, id: score.id}
    end

    it 'assigns the requested score as @score' do
      expect(assigns[:score]).to eq(score)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new score' do
        expect { post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, score: valid_create_params} }.to change(Score, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, score: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, score: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with a score over the maximum points' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, score: score_over_points_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id, id: score.id, score: valid_update_params}
      end

      it 'updates the requested score' do
        score.reload
        expect(score.updated_at).not_to eq(score.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id, id: score.id, score: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with a score over the maximum points' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id, id: score.id, score: score_over_points_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested score' do
      score.reload
      expect { delete :destroy, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id, id: score.id} }.to change(Score, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {group_id: score.session.assignment.group.id, assignment_id: score.session.assignment.id, session_id: score.session.id, id: score.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
