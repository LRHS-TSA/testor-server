require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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

  let(:valid_create_params) do
    {status: :awaiting_approval}
  end

  let(:invalid_create_params) do
    {status: :approved}
  end

  let(:valid_update_params) do
    {status: :awaiting_approval}
  end

  let(:invalid_update_params) do
    {status: :approved}
  end

  describe '#index' do
    before do
      get :index, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id}
    end

    it 'assigns all sessions as @sessions' do
      expect(assigns[:sessions]).to eq([session])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, id: session.id}
    end

    it 'assigns the requested session as @session' do
      expect(assigns[:session]).to eq(session)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    before do
      get :edit, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, id: session.id}
    end

    it 'assigns the requested session as @session' do
      expect(assigns[:session]).to eq(session)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new session' do
        expect { post :create, params: {group_id: assignment.group.id, assignment_id: assignment.id, session: valid_create_params} }.to change(Session, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group_id: assignment.group.id, assignment_id: assignment.id, session: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: assignment.group.id, assignment_id: assignment.id, session: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, id: session.id, session: valid_update_params}
      end

      it 'updates the requested session' do
        session.reload
        expect(session.updated_at).not_to eq(session.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, id: session.id, session: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
