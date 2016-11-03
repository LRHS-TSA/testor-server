# Controller for tests
class TestsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_with @tests
  end

  def show
    respond_with @test
  end

  def new
    respond_with @test
  end

  def edit
    respond_with @test
  end

  def create
    if @test.save
      head :created, location: test_path(@test)
    else
      render json: {error: @test.errors}, status: :bad_request
    end
  end

  def update
    if @test.update_attributes(update_params)
      head :ok
    else
      render json: {error: @test.errors}, status: :bad_request
    end
  end

  def destroy
    @test.destroy
    head :ok
  end

  private

  def create_params
    params.require(:test).permit(:name)
  end

  def update_params
    params.require(:test).permit(:name)
  end
end
