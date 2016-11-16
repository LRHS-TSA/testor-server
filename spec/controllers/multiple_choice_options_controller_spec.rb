require 'rails_helper'

RSpec.describe MultipleChoiceOptionsController, type: :controller do
  login_teacher

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test, type: :multiple_choice)
  end

  let(:wrong_type_question) do
    FactoryGirl.create(:question, test: test, type: :essay)
  end

  let(:multiple_choice_option) do
    FactoryGirl.create(:multiple_choice_option, question: question)
  end

  let(:valid_create_params) do
    o = FactoryGirl.build(:multiple_choice_option)
    {question_id: question.id, text: o.text, correct: o.correct}
  end

  let(:valid_update_params) do
    o = FactoryGirl.build(:multiple_choice_option)
    {text: o.text, correct: o.correct}
  end

  let(:invalid_create_params) do
    {question_id: nil, text: nil, correct: nil}
  end

  let(:invalid_update_params) do
    {text: nil, correct: nil}
  end

  describe '#create' do
    context 'with a multiple choice question' do
      context 'with valid parameters' do
        it 'creates a new multiple choice option' do
          expect { post :create, params: {test_id: test.id, question_id: question.id, multiple_choice_option: valid_create_params} }.to change(MultipleChoiceOption, :count).by(1)
        end

        it 'returns HTTP status 201 (Created)' do
          post :create, params: {test_id: test.id, question_id: question.id, multiple_choice_option: valid_create_params}
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :create, params: {test_id: test.id, question_id: question.id, multiple_choice_option: invalid_create_params}
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'with a not multiple choice question' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {test_id: test.id, question_id: wrong_type_question.id, multiple_choice_option: valid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {test_id: question.test.id, question_id: question.id, id: multiple_choice_option.id, multiple_choice_option: valid_update_params}
      end

      it 'updates the requested multiple choice option' do
        question.reload
        expect(multiple_choice_option.updated_at).not_to eq(multiple_choice_option.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {test_id: question.test.id, question_id: question.id, id: multiple_choice_option.id, multiple_choice_option: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the multiple choice option' do
      question.reload
      expect { delete :destroy, params: {test_id: question.test.id, question_id: question.id, id: multiple_choice_option.id} }.to change(MultipleChoiceOption, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {test_id: question.test.id, question_id: question.id, id: multiple_choice_option.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
