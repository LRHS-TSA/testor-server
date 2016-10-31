# Controller for groups
class GroupsController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource

  def index
    respond_with @groups
  end

  def show
    respond_with @group
  end

  def new
    respond_with @group
  end

  def edit
    respond_with @group
  end

  def create
    if @group.save
      head status: :created, location: event_path(event)
    else
      render json: {error: event.errors}, status: :bad_request
    end
  end

  def update
    if @group.update_attributes(update_params)
      head status: :ok
    else
      render json: {error: event.errors}, status: :bad_request
    end
  end

  private

  def update_params
    params.require(:group).permit(:name, :description)
  end
end
