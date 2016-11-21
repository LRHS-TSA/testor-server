require 'rails_helper'

RSpec.describe MultipleChoiceOptionsController, type: :controller do
  login_teacher

  let(:test) do
    FactoryGirl.create(:test, user: user)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test, question_type: :multiple_choice)
  end

  let(:wrong_type_question) do
    FactoryGirl.create(:question, test: test, question_type: :essay)
  end

  let(:multiple_choice_option) do
    FactoryGirl.create(:multiple_choice_option, question: question)
  end

  let(:valid_params) do
    o = FactoryGirl.build(:multiple_choice_option)
    {text: o.text, correct: o.correct}
  end

  let(:invalid_params) do
    {text: nil, correct: nil}
  end

  describe '#create' do
    context 'with a multiple choice question' do
      context 'with valid parameters' do
        it 'creates a new multiple choice option' do
          expect { post :create, params: {test_id: test.id, question_id: question.id, multiple_choice_option: valid_params} }.to change(MultipleChoiceOption, :count).by(1)
        end

        it 'returns HTTP status 201 (Created)' do
          post :create, params: {test_id: test.id, question_id: question.id, multiple_choice_option: valid_params}
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :create, params: {test_id: test.id, question_id: question.id, multiple_choice_option: invalid_params}
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'with a not multiple choice question' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {test_id: test.id, question_id: wrong_type_question.id, multiple_choice_option: valid_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {test_id: multiple_choice_option.question.test.id, question_id: multiple_choice_option.question.id, id: multiple_choice_option.id, multiple_choice_option: valid_params}
      end

      it 'updates the requested multiple choice option' do
        multiple_choice_option.reload
        expect(multiple_choice_option.updated_at).not_to eq(multiple_choice_option.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {test_id: multiple_choice_option.question.test.id, question_id: multiple_choice_option.question.id, id: multiple_choice_option.id, multiple_choice_option: invalid_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the multiple choice option' do
      multiple_choice_option.reload
      expect { delete :destroy, params: {test_id: multiple_choice_option.question.test.id, question_id: multiple_choice_option.question.id, id: multiple_choice_option.id} }.to change(MultipleChoiceOption, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {test_id: multiple_choice_option.question.test.id, question_id: multiple_choice_option.question.id, id: multiple_choice_option.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
