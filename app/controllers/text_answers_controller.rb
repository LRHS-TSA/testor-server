# Controller for text answers
class TextAnswersController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :assignment, through: :group
  load_and_authorize_resource :session, through: :assignment
  load_and_authorize_resource through: :session

  def index
    respond_with @text_answers
  end

  def show
    respond_with @text_answer
  end

  def create
    if @text_answer.session.locked? || (current_user.student? && !@session.used?)
      head :bad_request
      return
    end
    if @text_answer.question.nil? || (!@text_answer.question.essay? && !@text_answer.question.short_answer?) || @text_answer.question.test != @text_answer.session.assignment.test
      head :bad_request
      return
    end
    if @text_answer.save
      head :created, location: group_assignment_session_text_answer_path(@text_answer.session.assignment.group, @text_answer.session.assignment, @text_answer.session, @text_answer)
    else
      render json: {error: @text_answer.errors}, status: :bad_request
    end
  end

  def update
    if @text_answer.session.locked?
      head :bad_request
      return
    end
    if @text_answer.update_attributes(update_params)
      head :ok
    else
      render json: {error: @text_answer.errors}, status: :bad_request
    end
  end

  private

  def create_params
    params.require(:text_answer).permit(:question_id, :text)
  end

  def update_params
    params.require(:text_answer).permit(:text)
  end
end
