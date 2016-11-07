# Controller for assignments
class AssignmentsController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource through: :group

  def index
    respond_with @assignments
  end

  def show
    respond_with @assignment
  end

  def new
    respond_with @assignment
  end

  def edit
    respond_with @assignment
  end

  def create
    if !@assignment.test.nil? && @assignment.test.user != current_user
      head :bad_request
      return
    end
    if @assignment.save
      head :created, location: group_assignment_path(@assignment.group, @assignment)
    else
      render json: {error: @assignment.errors}, status: :bad_request
    end
  end

  def update
    if @assignment.update_attributes(update_params)
      head :ok
    else
      render json: {error: @assignment.errors}, status: :bad_request
    end
  end

  def destroy
    @assignment.destroy
    head :ok
  end

  private

  def create_params
    params.require(:assignment).permit(:name, :test_id, :start_date, :end_date, :length)
  end

  def update_params
    params.require(:assignment).permit(:name, :start_date, :end_date, :length)
  end
end
