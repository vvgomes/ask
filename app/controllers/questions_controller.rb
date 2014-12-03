class QuestionsController < ApplicationController
  def index

  end

  def new
    @question = Question.new(:user => current_user)
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
