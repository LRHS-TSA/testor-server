# Conttoler for members, also handles joining group by token
class MembersController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource :group, except: :join_group
  load_and_authorize_resource through: :group, except: :join_group
  authorize_resource only: :join_group

  def index
    respond_with @members
  end

  def show
    respond_with @member
  end

  def join_group
    if current_user.teacher?
      @group = Group.find_by(teacher_token: params[:token])
    elsif current_user.student?
      @group = Group.find_by(student_token: params[:token])
    end

    if @group.nil?
      head :bad_request
      return
    end
    if Member.find_by(group: @group, user: current_user)
      head :bad_request
      return
    end

    Member.create(group: @group, user: current_user)
    head :created, location: group_path(@group)
  end

  def destroy
    @member.destroy
    head :ok
  end
end
