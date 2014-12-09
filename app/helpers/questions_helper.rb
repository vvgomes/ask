module QuestionsHelper
  def like_or_dislike(question)
    like = current_user.likes.where(:question => question).first
    if like
      {
        :path => like_path(like),
        :method => :delete,
        :class => 'liked'
      }
    else
      {
        :path => likes_path(:question_id => question.id),
        :method => :create,
        :class => ''
      }
    end
  end
end
