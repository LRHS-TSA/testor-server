require 'rails_helper'

RSpec.describe MatchingPairsController, type: :controller do
  login_teacher

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test, question_type: :matching)
  end

  let(:wrong_type_question) do
    FactoryGirl.create(:question, test: test, question_type: :essay)
  end

  let(:matching_pair) do
    FactoryGirl.create(:matching_pair, question: question)
  end

  let(:valid_params) do
    p = FactoryGirl.build(:matching_pair)
    {item1: p.item1, item2: p.item2}
  end

  let(:invalid_params) do
    {item1: nil, item2: nil}
  end

  describe '#create' do
    context 'with a matching question' do
      context 'with valid parameters' do
        it 'creates a new matching pair' do
          expect { post :create, params: {test_id: test.id, question_id: question.id, matching_pair: valid_params} }.to change(MatchingPair, :count).by(1)
        end

        it 'returns HTTP status 201 (Created)' do
          post :create, params: {test_id: test.id, question_id: question.id, matching_pair: valid_params}
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :create, params: {test_id: test.id, question_id: question.id, matching_pair: invalid_params}
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'with a not matching question' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {test_id: test.id, question_id: wrong_type_question.id, matching_pair: valid_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {test_id: matching_pair.question.test.id, question_id: matching_pair.question.id, id: matching_pair.id, matching_pair: valid_params}
      end

      it 'updates the requested matching pair' do
        matching_pair.reload
        expect(matching_pair.updated_at).not_to eq(matching_pair.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {test_id: matching_pair.question.test.id, question_id: matching_pair.question.id, id: matching_pair.id, matching_pair: invalid_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the matching_pair' do
      matching_pair.reload
      expect { delete :destroy, params: {test_id: matching_pair.question.test.id, question_id: matching_pair.question.id, id: matching_pair.id} }.to change(MatchingPair, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {test_id: matching_pair.question.test.id, question_id: matching_pair.question.id, id: matching_pair.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
