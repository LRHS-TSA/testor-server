# Controller for groups
class GroupsController < ApplicationController
  respond_to :html, :json
  load_resource :member, through: :group

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
      Member.create(user: current_user, group: @group)
      head :created, location: group_path(@group)
    else
      render json: {error: @group.errors}, status: :bad_request
    end
  end

  def update
    if @group.update_attributes(update_params)
      head :ok
    else
      render json: {error: @group.errors}, status: :bad_request
    end
  end

  private

  def create_params
    params.require(:group).permit(:name, :description)
  end

  def update_params
    params.require(:group).permit(:name, :description)
  end
end
