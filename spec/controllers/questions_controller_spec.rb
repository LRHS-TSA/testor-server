require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  login_teacher

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test)
  end

  let(:valid_create_params) do
    q = FactoryGirl.build(:question)
    {text: q.text, question_type: q.question_type, points: q.points}
  end

  let(:valid_update_params) do
    q = FactoryGirl.build(:question)
    {text: q.text, points: q.points}
  end

  let(:invalid_create_params) do
    {text: nil, question_type: nil, points: nil}
  end

  let(:invalid_update_params) do
    {text: nil, points: nil}
  end

  describe '#index' do
    before do
      get :index, params: {test_id: question.test.id}
    end

    it 'assigns all questions as @questions' do
      expect(assigns[:questions]).to eq([question])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new question' do
        expect { post :create, params: {test_id: test.id, question: valid_create_params} }.to change(Question, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {test_id: test.id, question: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {test_id: test.id, question: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {test_id: question.test.id, id: question.id, question: valid_update_params}
      end

      it 'updates the requested question' do
        question.reload
        expect(question.updated_at).not_to eq(question.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {test_id: question.test.id, id: question.id, question: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested question' do
      question.reload
      expect { delete :destroy, params: {test_id: question.test.id, id: question.id} }.to change(Question, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {test_id: question.test.id, id: question.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
