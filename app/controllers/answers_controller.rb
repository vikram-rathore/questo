class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_question!

  def index
    @answers = @question.answers.order(created_at: :desc)
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    render json: { errors: @answer.errors }, status: :unprocessable_entity unless @answer.save
  end

  def destroy
    @answer = @question.answers.find(params[:id])

    if @answer.user_id == @current_user_id
      @answer.destroy
      render json: {}
    else
      render json: { errors: { answer: ['not owned by user'] } }, status: :forbidden
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question!
    @question = Question.find_by_slug!(params[:question_slug])
  end
end