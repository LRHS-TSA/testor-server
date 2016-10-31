require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  login_teacher

  let(:group) do
    FactoryGirl.create(:group)
  end

  let(:valid_create_params) do
    {name: FFaker::Education.school_name, description: FFaker::Lorem.paragraph}
  end

  let(:invalid_create_params) do
    {name: nil, description: nil}
  end

  let(:valid_update_params) do
    {name: ' ' + FFaker::Education.school_name, description: ' ' + FFaker::Lorem.paragraph}
  end

  let(:invalid_update_params) do
    {name: nil, description: nil}
  end

  describe '#index' do
    it 'assigns all groups as @groups' do
      group = FactoryGirl.create(:group)
      get :index
      expect(assigns[:groups]).to eq([group])
    end
  end

  describe '#show' do
    before do
      get :show, params: {id: group.id}
    end

    it 'assigns the requested group as @group' do
      expect(assigns[:group]).to eq(group)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    before do
      get :new
    end

    it 'assigns a new group as @group' do
      expect(assigns[:group]).to be_a_new(Group)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    before do
      FactoryGirl.create(:member, user: user, group: group)
      get :edit, params: {id: group.id}
    end

    it 'assigns the requested group as @group' do
      expect(assigns[:group]).to eq(group)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new group' do
        expect { post :create, params: {group: valid_create_params} }.to change(Group, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    before do
      FactoryGirl.create(:member, user: user, group: group)
    end

    context 'with valid parameters' do
      before do
        put :update, params: {id: group.id, group: valid_update_params}
      end

      it 'updates the requested group' do
        group.reload
        expect(group.updated_at).not_to eq(group.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {id: group.id, group: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
