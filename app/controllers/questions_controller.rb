class QuestionsController < ApplicationController
  before_filter :authenticate!

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    @question.user = current_user
    @question.description = params[:question][:description]
    if @question.save
      flash[:success] = 'Question added.'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    return forbid! unless @question.user == current_user
  end

  def update
    @question = Question.find(params[:id])
    return forbid! unless @question.user == current_user
    @question.description = params[:question][:description]
    if @question.save
      flash[:success] = 'Question updated.'
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    q = Question.find(params[:id])
    return forbid! unless q.user == current_user
    q.destroy
    flash[:success] = 'Question removed.'
    redirect_to questions_path
  end

  def mine
    @questions = Question.where(:user => current_user)
    render :index
  end

  def favorite
    @questions = Like.where(:user => current_user).map(&:question)
    render :index
  end
end
