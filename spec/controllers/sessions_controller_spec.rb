require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  login_student

  let(:group) do
    FactoryGirl.create(:member, user: user).group
  end

  let(:assignment) do
    FactoryGirl.create(:assignment, group: group, test: test)
  end

  let(:before_start_date_assignment) do
    FactoryGirl.create(:assignment, group: group, test: test, start_date: 1.day.from_now)
  end

  let(:after_end_date_assignment) do
    FactoryGirl.create(:assignment, group: group, test: test, end_date: 1.day.ago)
  end

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:session) do
    FactoryGirl.create(:session, assignment: assignment, user: user)
  end

  let(:after_end_date_session) do
    FactoryGirl.create(:session, assignment: after_end_date_assignment, user: user)
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

    context 'before the start date' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: before_start_date_assignment.group.id, assignment_id: before_start_date_assignment.id, session: valid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'after the end date' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: after_end_date_assignment.group.id, assignment_id: after_end_date_assignment.id, session: valid_create_params}
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

    context 'after the end date' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: after_end_date_session.assignment.group.id, assignment_id: after_end_date_session.assignment.id, id: after_end_date_session.id, session: valid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#load_questions' do
    before do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :load_questions, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, id: session.id}
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'sets the session as used' do
      session.reload
      expect(session.status).to eq('used')
    end

    it 'sets start_time' do
      session.reload
      expect(session.start_time).not_to be_nil
    end
  end
end
