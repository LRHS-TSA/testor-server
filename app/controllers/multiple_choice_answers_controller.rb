# Controller for multiple choice answers
class MultipleChoiceAnswersController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :assignment, through: :group
  load_and_authorize_resource :session, through: :assignment
  load_and_authorize_resource through: :session

  def index
    respond_with @multiple_choice_answers
  end

  def show
    respond_with @multiple_choice_answer
  end

  def create
    if @multiple_choice_answer.question.nil? || !@multiple_choice_answer.question.multiple_choice? || @multiple_choice_answer.question.test != @multiple_choice_answer.session.assignment.test
      head :bad_request
      return
    end
    if @multiple_choice_answer.multiple_choice_option.nil? || @multiple_choice_answer.question.nil? || @multiple_choice_answer.multiple_choice_option.question != @multiple_choice_answer.question
      head :bad_request
      return
    end
    if @multiple_choice_answer.save
      head :created, location: group_assignment_session_multiple_choice_answer_path(@multiple_choice_answer.session.assignment.group, @multiple_choice_answer.session.assignment, @multiple_choice_answer.session, @multiple_choice_answer)
    else
      render json: {error: @multiple_choice_answer.errors}, status: :bad_request
    end
  end

  def update
    if update_params[:multiple_choice_option_id].nil? || MultipleChoiceOption.find_by(id: update_params[:multiple_choice_option_id]).nil? || MultipleChoiceOption.find_by(id: update_params[:multiple_choice_option_id]).question.id != @multiple_choice_answer.question.id
      head :bad_request
      return
    end
    if @multiple_choice_answer.update_attributes(update_params)
      head :ok
    else
      render json: {error: @multiple_choice_answer.errors}, status: :bad_request
    end
  end

  private

  def create_params
    params.require(:multiple_choice_answer).permit(:question_id, :multiple_choice_option_id)
  end

  def update_params
    params.require(:multiple_choice_answer).permit(:multiple_choice_option_id)
  end
end
