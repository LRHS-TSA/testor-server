# Controller for matching pair answers
class MatchingPairAnswersController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :assignment, through: :group
  load_and_authorize_resource :session, through: :assignment
  load_and_authorize_resource through: :session

  def index
    respond_with @matching_pair_answers
  end

  def show
    respond_with @matching_pair_answer
  end

  def create
    if @matching_pair_answer.session.locked?
      head :bad_request
      return
    end
    if @matching_pair_answer.question.nil? || !@matching_pair_answer.question.matching? || @matching_pair_answer.question.test != @matching_pair_answer.session.assignment.test
      head :bad_request
      return
    end
    if @matching_pair_answer.item1.nil? || @matching_pair_answer.item2.nil? || @matching_pair_answer.question.nil? || MatchingPair.find_by(question: @matching_pair_answer.question, item1: @matching_pair_answer.item1).nil? || MatchingPair.find_by(question: @matching_pair_answer.question, item2: @matching_pair_answer.item2).nil?
      head :bad_request
      return
    end
    if @matching_pair_answer.save
      head :created, location: group_assignment_session_matching_pair_answer_path(@matching_pair_answer.session.assignment.group, @matching_pair_answer.session.assignment, @matching_pair_answer.session, @matching_pair_answer)
    else
      render json: {error: @matching_pair_answer.errors}, status: :bad_request
    end
  end

  def update
    if @matching_pair_answer.session.locked?
      head :bad_request
      return
    end
    if update_params[:item2].nil? || MatchingPair.find_by(question: @matching_pair_answer.question, item2: update_params[:item2]).nil?
      head :bad_request
      return
    end
    if @matching_pair_answer.update_attributes(update_params)
      head :ok
    else
      render json: {error: @matching_pair_answer.errors}, status: :bad_request
    end
  end

  private

  def create_params
    params.require(:matching_pair_answer).permit(:question_id, :item1, :item2)
  end

  def update_params
    params.require(:matching_pair_answer).permit(:item2)
  end
end
