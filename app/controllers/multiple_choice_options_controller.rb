# Controller for multiple choice options
class MultipleChoiceOptionsController < ApplicationController
  load_and_authorize_resource :test
  load_and_authorize_resource :question, through: :test
  load_and_authorize_resource through: :question

  def create
    unless @multiple_choice_option.question.multiple_choice?
      head :bad_request
      return
    end

    if @multiple_choice_option.save
      head :created, location: test_question_multiple_choice_option_path(@multiple_choice_option.test, @multiple_choice_option.question, @multiple_choice_option)
    else
      render json: {error: @multiple_choice_option.errors}, status: :bad_request
    end
  end

  def update
    if @multiple_choice_option.update_attributes(update_params)
      head :ok
    else
      render json: {error: @multiple_choice_option.errors}, status: :bad_request
    end
  end

  def destroy
    @multiple_choice_option.destroy
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
