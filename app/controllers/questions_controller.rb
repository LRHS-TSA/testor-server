# Controller for questions
class QuestionsController < ApplicationController
  load_and_authorize_resource :test
  load_and_authorize_resource through: :test

  def index
    respond_with @questions
  end

  def create
    if @question.save
      head :created, location: test_question_path(@question.test, @question)
    else
      render json: {error: @question.errors}, status: :bad_request
    end
  end

  def update
    if @question.update_attributes(update_params)
      head :ok
    else
      render json: {error: @question.errors}, status: :bad_request
    end
  end

  def destroy
    @question.destroy
    head :ok
  end

  private

  def create_params
    params.require(:question).permit(:test_id, :text, :question_type)
  end

  def update_params
    params.require(:question).permit(:text, :question_type)
  end
end