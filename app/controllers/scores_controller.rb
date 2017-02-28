# Controller for scores
class ScoresController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :assignment, through: :group
  load_and_authorize_resource :session, through: :assignment
  load_and_authorize_resource through: :session

  def index
    respond_with @scores
  end

  def show
    respond_with @score
  end

  def create
    if @score.score.nil? || @score.score.to_i > @score.question.points
      head :bad_request
      return
    end
    if @score.save
      head :created, location: group_assignment_session_score_path(@score.session.assignment.group, @score.session.assignment, @score.session, @score)
    else
      render json: {error: @score.errors}, status: :bad_request
    end
  end

  def update
    if update_params[:score].nil? || update_params[:score].to_i > @score.question.points
      head :bad_request
      return
    end
    if @score.update_attributes(update_params)
      head :ok
    else
      render json: {error: @score.errors}, status: :bad_request
    end
  end

  def destroy
    @score.destroy
    head :ok
  end

  private

  def create_params
    params.require(:score).permit(:question_id, :score)
  end

  def update_params
    params.require(:score).permit(:score)
  end
end
