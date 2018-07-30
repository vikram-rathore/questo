class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question!

  def create
    current_user.favorite(@question)

    render 'questions/show'
  end

  def destroy
    current_user.unfavorite(@question)

    render 'questions/show'
  end

  private
  def find_question!
    @question = Question.find_by_slug!(params[:question_slug])
  end
end