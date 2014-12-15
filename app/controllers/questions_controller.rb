class QuestionsController < ApplicationController
  before_filter :authenticate!

  def index
    @questions = 
      apply_pagination(
        apply_order(
          apply_tags(Question)
        )
      )
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
    @question.tag_list = params[:question][:tag_list]
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
    @question.tag_list = params[:question][:tag_list]
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
    flash[:notice] = 'Question removed.'
    redirect_to questions_path
  end

  def mine
    @questions = 
      apply_pagination(
        apply_order(
          apply_tags(
            Question.where(:user => current_user)
          )
        )
      )
    render :index
  end

  def favorite
    @questions = 
      apply_pagination(
        apply_order(
          apply_tags(current_user.favorites)
        )
      )
    render :index
  end

  private

  def apply_tags(scope)
    return scope unless params[:tag_filter]
    tags = params[:tag_filter].downcase.split(',')
    scope.tagged_with(tags, :any => true)
  end

  def apply_order(scope)
    #scope.order(:created_at => :desc)
    scope
  end

  def apply_pagination(scope)
    scope.paginate(:page => params[:page], :per_page => 30)
  end
end
