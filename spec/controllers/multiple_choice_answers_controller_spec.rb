require 'rails_helper'

RSpec.describe MultipleChoiceAnswersController, type: :controller do
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
    FactoryGirl.create(:question, test: test, question_type: :multiple_choice)
  end

  let(:invalid_type_question) do
    FactoryGirl.create(:question, test: test, question_type: :essay)
  end

  let(:invalid_question) do
    FactoryGirl.create(:question, question_type: :multiple_choice)
  end

  let(:multiple_choice_option) do
    FactoryGirl.create(:multiple_choice_option, question: question)
  end

  let(:update_multiple_choice_option) do
    FactoryGirl.create(:multiple_choice_option, question: question)
  end

  let(:invalid_multiple_choice_option) do
    FactoryGirl.create(:multiple_choice_option)
  end

  let(:invalid_question_multiple_choice_option) do
    FactoryGirl.create(:multiple_choice_option, question: invalid_question)
  end

  let(:multiple_choice_answer) do
    FactoryGirl.create(:multiple_choice_answer, session: session, question: question, multiple_choice_option: multiple_choice_option)
  end

  let(:valid_create_params) do
    {question_id: question.id, multiple_choice_option_id: multiple_choice_option.id}
  end

  let(:invalid_create_params) do
    {question_id: question.id, multiple_choice_option_id: nil}
  end

  let(:invalid_question_type_create_params) do
    {question_id: invalid_type_question.id, multiple_choice_option_id: nil}
  end

  let(:invalid_multiple_choice_option_create_params) do
    {question_id: question.id, multiple_choice_option_id: invalid_multiple_choice_option.id}
  end

  let(:invalid_question_create_params) do
    {question_id: invalid_question.id, multiple_choice_option_id: invalid_question_multiple_choice_option}
  end

  let(:valid_update_params) do
    {multiple_choice_option_id: update_multiple_choice_option.id}
  end

  let(:invalid_update_params) do
    {multiple_choice_option_id: nil}
  end

  let(:invalid_multiple_choice_option_update_params) do
    {multiple_choice_option_id: invalid_multiple_choice_option.id}
  end

  describe '#index' do
    before do
      get :index, params: {group_id: multiple_choice_answer.session.assignment.group.id, assignment_id: multiple_choice_answer.session.assignment.id, session_id: multiple_choice_answer.session.id}
    end

    it 'assigns all multiple choice answers as @multiple_choice_answers' do
      expect(assigns[:multiple_choice_answers]).to eq([multiple_choice_answer])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    before do
      get :show, params: {group_id: multiple_choice_answer.session.assignment.group.id, assignment_id: multiple_choice_answer.session.assignment.id, session_id: multiple_choice_answer.session.id, id: multiple_choice_answer.id}
    end

    it 'assigns the requested multiple choice answer as @multiple_choice_answer' do
      expect(assigns[:multiple_choice_answer]).to eq(multiple_choice_answer)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new multiple choice answer' do
        expect { post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, multiple_choice_answer: valid_create_params} }.to change(MultipleChoiceAnswer, :count).by(1)
      end

      it 'returns HTTP status 201 (Created)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, multiple_choice_answer: valid_create_params}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, multiple_choice_answer: invalid_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid question type' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, multiple_choice_answer: invalid_question_type_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid multiple choice option' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, multiple_choice_answer: invalid_multiple_choice_option_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid question' do
      it 'returns HTTP status 400 (Bad Request)' do
        post :create, params: {group_id: session.assignment.group.id, assignment_id: session.assignment.id, session_id: session.id, multiple_choice_answer: invalid_question_create_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      before do
        put :update, params: {group_id: multiple_choice_answer.session.assignment.group.id, assignment_id: multiple_choice_answer.session.assignment.id, session_id: multiple_choice_answer.session.id, id: multiple_choice_answer.id, multiple_choice_answer: valid_update_params}
      end

      it 'updates the requested multiple choice answer' do
        multiple_choice_answer.reload
        expect(multiple_choice_answer.updated_at).not_to eq(multiple_choice_answer.created_at)
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: multiple_choice_answer.session.assignment.group.id, assignment_id: multiple_choice_answer.session.assignment.id, session_id: multiple_choice_answer.session.id, id: multiple_choice_answer.id, multiple_choice_answer: invalid_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid multiple choice option' do
      it 'returns HTTP status 400 (Bad Request)' do
        put :update, params: {group_id: multiple_choice_answer.session.assignment.group.id, assignment_id: multiple_choice_answer.session.assignment.id, session_id: multiple_choice_answer.session.id, id: multiple_choice_answer.id, multiple_choice_answer: invalid_multiple_choice_option_update_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
