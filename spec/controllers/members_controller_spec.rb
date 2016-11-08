require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:group) do
    FactoryGirl.create(:group)
  end

  let(:member) do
    FactoryGirl.create(:member, user: user)
  end

  describe '#index' do
    login_teacher

    before do
      get :index, params: {group_id: member.group.id}
    end

    it 'assigns all members as @members' do
      expect(assigns[:members]).to eq([member])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    login_teacher

    before do
      get :show, params: {group_id: member.group.id, id: member.id}
    end

    it 'assigns the requested member as @member' do
      expect(assigns[:member]).to eq(member)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#join_group' do
    context 'while already in the group' do
      login_student

      it 'returns HTTP status 400 (Bad Request)' do
        post :join_group, params: {token: member.group.student_token}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'as a teacher' do
      login_teacher

      context 'with a valid token' do
        it 'creates a member' do
          expect { post :join_group, params: {token: group.teacher_token} }.to change(Member, :count).by(1)
        end

        it 'returns HTTP status 201 (Created)' do
          post :join_group, params: {token: group.teacher_token}
          expect(response).to have_http_status(:created)
        end
      end

      context 'with an invalid token' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :join_group, params: {token: group.student_token}
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'as a student' do
      login_student

      context 'with a valid token' do
        it 'creates a member' do
          expect { post :join_group, params: {token: group.student_token} }.to change(Member, :count).by(1)
        end

        it 'returns HTTP status 200 (Created)' do
          post :join_group, params: {token: group.student_token}
          expect(response).to have_http_status(:created)
        end
      end

      context 'with an invalid token' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :join_group, params: {token: group.teacher_token}
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe '#destroy' do
    login_teacher

    it 'destroys the requested member' do
      member.reload
      expect { delete :destroy, params: {group_id: member.group.id, id: member.id} }.to change(Member, :count).by(-1)
    end

    it 'returns HTTP status 200 (OK)' do
      delete :destroy, params: {group_id: member.group.id, id: member.id}
      expect(response).to have_http_status(:ok)
    end
  end
end
