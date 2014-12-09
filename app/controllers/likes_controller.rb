class LikesController < ApplicationController
  before_filter :authenticate!

  def create
    q = Question.find(params[:question_id])
    like = Like.new(:user => current_user, :question => q)
    flash[:success] = 'Question added to your favorites.' if like.save
    redirect_to(request.referer || root_path)
  end

  def destroy
    like = Like.find(params[:id])
    return forbid! unless like.user == current_user
    like.destroy
    flash[:success] = 'Question removed from your favorites.'
    redirect_to(request.referer || root_path)
  end
end
