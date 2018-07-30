class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.all.includes(:user)

    @questions = @questions.asked_by(params[:author]) if params[:author].present?

    @questions_count = @questions.count

    @questions = @questions.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
end