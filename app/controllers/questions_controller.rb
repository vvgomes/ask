class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show

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

  end

  def update

  end

  def destroy

  end
end
