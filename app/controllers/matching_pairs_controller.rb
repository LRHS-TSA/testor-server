# Controller for matching pairs
class MatchingPairsController < ApplicationController
  load_and_authorize_resource :test
  load_and_authorize_resource :question, through: :test
  load_and_authorize_resource through: :question

  def create
    unless @matching_pair.question.matching?
      head :bad_request
      return
    end

    if @matching_pair.save
      head :created, location: test_question_matching_pair_path(@matching_pair.question.test, @matching_pair.question, @matching_pair)
    else
      render json: {error: @matching_pair.errors}, status: :bad_request
    end
  end

  def update
    if @matching_pair.update_attributes(update_params)
      head :ok
    else
      render json: {error: @matching_pair.errors}, status: :bad_request
    end
  end

  def destroy
    @matching_pair.destroy
    head :ok
  end

  private

  def create_params
    params.require(:matching_pair).permit(:item1, :item2)
  end

  def update_params
    params.require(:matching_pair).permit(:item1, :item2)
  end
end
