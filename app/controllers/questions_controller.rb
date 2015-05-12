class QuestionsController < ApplicationController
  before_filter :authenticate!

  def index
    @questions = build_question_list
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
    @questions = build_question_list(current_user.questions)
    render :index
  end

  def favorite
    @questions = build_question_list(current_user.favorites)
    render :index
  end

  def by
    @questions = build_question_list(User.find_by_email(params[:email]).questions)
    render :index
  end

  private

  def build_question_list(scope=Question)
    apply_pagination(apply_order(apply_tags(scope)))
  end

  def apply_pagination(scope)
    scope.paginate(:page => params[:page], :per_page => 30)
  end

  def apply_order(scope)
    scope.order(:created_at => :desc)
  end

  def apply_tags(scope)
    return scope unless params[:tag_filter]
    tags = params[:tag_filter].downcase.split(',')
    scope.tagged_with(tags, :any => true)
  end
end
