# Controller for sessions
class SessionsController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :assignment, through: :group
  load_and_authorize_resource through: :assignment

  def index
    respond_with @sessions
  end

  def show
    respond_with @session
  end

  def edit
    respond_with @session
  end

  def create
    if @session.locked?
      head :bad_request
      return
    end
    if current_user.student? && @session.status != 'awaiting_approval'
      head :bad_request
      return
    end
    @session.user = current_user
    if @session.save
      head :created, location: group_assignment_session_path(@session.assignment.group, @session.assignment, @session)
    else
      render json: {error: @session.errors}, status: :bad_request
    end
  end

  def update
    if @session.locked?
      head :bad_request
      return
    end
    if current_user.student? && update_params[:status] != 'awaiting_approval'
      head :bad_request
      return
    end
    if @session.update_attributes(update_params)
      head :ok
    else
      render json: {error: @session.errors}, status: :bad_request
    end
  end

  def load_questions
    respond_to :json
    unless current_user.student?
      head :bad_request
      return
    end
    @session.status = :used
    @session.save!
    respond_with @session
  end

  private

  def create_params
    params.require(:session).permit(:status)
  end

  def update_params
    params.require(:session).permit(:status)
  end
end
