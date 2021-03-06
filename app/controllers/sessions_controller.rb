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
    if current_user.student? && !@session.awaiting_approval?
      head :bad_request
      return
    end
    @session.user = current_user
    if @session.save
      if !@session.assignment.length.nil?
        GradeSessionJob.set(wait: @session.length.seconds).perform_later(@session)
      elsif !@session.assignment.end_date.nil?
        GradeSessionJob.set(wait_until: @session.end_date).perform_later(@session)
      end
      head :created, location: group_assignment_session_path(@session.assignment.group, @session.assignment, @session)
    else
      render json: {error: @session.errors}, status: :bad_request
    end
  end

  def update
    if @session.locked? || (current_user.student? && update_params[:status] != 'awaiting_approval')
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
    unless current_user.student? && @session.approved?
      head :bad_request
      return
    end
    @session.status = :used
    @session.start_time = Time.now.utc
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
