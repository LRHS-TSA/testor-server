require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  login_teacher

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:valid_params) do
    t = FactoryGirl.build(:test)
    {name: t.name}
  end

  let(:invalid_params) do
    {name: nil}
  end

  describe '#index' do
    before do
      test.reload
      get :index
    end

    it 'assigns all tests as @tests' do
      expect(assigns[:tests]).to eq([test])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {id: test.id}
    end

    it 'assigns the requested test as @test' do
      expect(assigns[:test]).to eq(test)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    before do
      get :new
    end

    it 'assigns a new test as @test' do
      expect(assigns[:test]).to be_a_new(Test)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    before do
      get :edit, params: {id: test.id}
    end

    it 'assigns the requested test as @test' do
      expect(assigns[:test]).to eq(test)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new test' do
        expect { post :create, params: {test: valid_params} }.to change(Test, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {test: valid_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {test: invalid_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {id: test.id, test: valid_params}
      end

      it 'updates the requested test' do
        test.reload
        expect(test.updated_at).not_to eq(test.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {id: test.id, test: invalid_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested test' do
      test.reload
      expect { delete :destroy, params: {id: test.id} }.to change(Test, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {id: test.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
