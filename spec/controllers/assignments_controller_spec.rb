require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  login_teacher

  let(:group) do
    FactoryGirl.create(:member, user: user).group
  end

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:assignment) do
    FactoryGirl.create(:assignment, group: group, test: test)
  end

  let(:valid_create_params) do
    a = FactoryGirl.build(:assignment)
    {name: a.name, test_id: test.id, start_date: a.start_date, end_date: a.end_date, length: a.length}
  end

  let(:valid_update_params) do
    a = FactoryGirl.build(:assignment)
    {name: a.name, start_date: a.start_date, end_date: a.end_date, length: a.length}
  end

  let(:invalid_create_params) do
    {name: nil, test_id: nil, start_date: nil, end_date: nil, length: nil}
  end

  let(:invalid_update_params) do
    {name: nil, start_date: nil, end_date: nil, length: nil}
  end

  describe '#index' do
    before do
      get :index, params: {group_id: assignment.group.id}
    end

    it 'assigns all assignments as @assignments' do
      expect(assigns[:assignments]).to eq([assignment])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {group_id: assignment.group.id, id: assignment.id}
    end

    it 'assigns the requested assignment as @assignment' do
      expect(assigns[:assignment]).to eq(assignment)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    before do
      get :new, params: {group_id: assignment.group.id}
    end

    it 'assigns a new assignment as @assignment' do
      expect(assigns[:assignment]).to be_a_new(Assignment)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    before do
      get :edit, params: {group_id: assignment.group.id, id: assignment.id}
    end

    it 'assigns the requested assignment as @assignment' do
      expect(assigns[:assignment]).to eq(assignment)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new assignment' do
        expect { post :create, params: {group_id: group.id, assignment: valid_create_params} }.to change(Assignment, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group_id: group.id, assignment: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: group.id, assignment: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {group_id: assignment.group.id, id: assignment.id, assignment: valid_update_params}
      end

      it 'updates the requested assignment' do
        assignment.reload
        expect(assignment.updated_at).not_to eq(assignment.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: assignment.group.id, id: assignment.id, assignment: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested assignment' do
      assignment.reload
      expect { delete :destroy, params: {group_id: assignment.group.id, id: assignment.id} }.to change(Assignment, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {group_id: assignment.group.id, id: assignment.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
