class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all.includes(:user)

    @questions = @questions.tagged_with(params[:tag]) if params[:tag].present?
    @questions = @questions.asked_by(params[:author]) if params[:author].present?
    @questions = @questions.favorited_by(params[:favorited]) if params[:favorited].present?

    @questions_count = @questions.count

    @questions = @questions.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      render :show
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  def show
    @question = Question.find_by_slug!(params[:slug])
  end

  def update
    @question = Question.find_by_slug!(params[:slug])

    if @question.user_id == @current_user_id
      @question.update_attributes(question_params)

      render :show
    else
      render json: { errors: { question: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @question = Question.find_by_slug!(params[:slug])

    if @question.user_id == @current_user_id
      @question.destroy

      render json: {}
    else
      render json: { errors: { question: ['not owned by user'] } }, status: :forbidden
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, tag_list: [])
  end
end