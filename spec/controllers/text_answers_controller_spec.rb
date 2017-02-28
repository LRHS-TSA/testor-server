require 'rails_helper'

RSpec.describe TextAnswersController, type: :controller do
  login_student

  let(:group) do
    FactoryGirl.create(:member, user: user).group
  end

  let(:assignment) do
    FactoryGirl.create(:assignment, group: group, test: test)
  end

  let(:test) do
    FactoryGirl.create(:test)
  end

  let(:session) do
    FactoryGirl.create(:session, assignment: assignment, user: user)
  end

  let(:question) do
    FactoryGirl.create(:question, test: test, question_type: :essay)
  end

  let(:invalid_type_question) do
    FactoryGirl.create(:question, test: test, question_type: :multiple_choice)
  end

  let(:invalid_question) do
    FactoryGirl.create(:question, question_type: :essay)
  end

  let(:text_answer) do
    FactoryGirl.create(:text_answer, session: session, question: question)
  end

  let(:valid_create_params) do
    ta = FactoryGirl.build(:text_answer)
    {question_id: question.id, text: ta.text}
  end

  let(:invalid_create_params) do
    {question_id: question.id, text: nil}
  end

  let(:invalid_question_type_create_params) do
    ta = FactoryGirl.build(:text_answer)
    {question_id: invalid_type_question.id, text: ta.text}
  end

  let(:invalid_question_create_params) do
    ta = FactoryGirl.build(:text_answer)
    {question_id: invalid_question.id, text: ta.text}
  end

  let(:valid_update_params) do
    ta = FactoryGirl.build(:text_answer)
    {text: ta.text}
  end

  let(:invalid_update_params) do
    {text: nil}
  end

  describe '#index' do
    before do
      get :index, params: {group_id: text_answer.session.assignment.group.id, assignment_id: text_answer.session.assignment.id, session_id: text_answer.session.id}
    end

    it 'assigns all text answers as @text_answers' do
      expect(assigns[:text_answers]).to eq([text_answer])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {group_id: text_answer.session.assignment.group.id, assignment_id: text_answer.session.assignment.id, session_id: text_answer.session.id, id: text_answer.id}
    end

    it 'assigns the requested text answer as @text_answer' do
      expect(assigns[:text_answer]).to eq(text_answer)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new text answer' do
        expect { post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, text_answer: valid_create_params} }.to change(TextAnswer, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, text_answer: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, text_answer: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid question type' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, text_answer: invalid_question_type_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid question' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, text_answer: invalid_question_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {group_id: text_answer.session.assignment.group.id, assignment_id: text_answer.session.assignment.id, session_id: text_answer.session.id, id: text_answer.id, text_answer: valid_update_params}
      end

      it 'updates the requested text answer' do
        text_answer.reload
        expect(text_answer.updated_at).not_to eq(text_answer.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: text_answer.session.assignment.group.id, assignment_id: text_answer.session.assignment.id, session_id: text_answer.session.id, id: text_answer.id, text_answer: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
