require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  setup do
    @me = User.create(:email => 'me@tw.com')
    @liked_question = Question.create({
      :user => @me,
      :description => 'What is your favorite language?'
    })
    @not_liked_question = Question.create({
      :user => @me,
      :description => 'Do you believe in God?'
    })
    @like = Like.create(:user => @me, :question => @liked_question)
    session[:user_id] = @me.id
  end

  teardown do
    Like.delete_all
    Question.delete_all
    User.delete_all
  end

  test 'allows me to like a question I did not like yet' do
    post :create, :like => { :question_id => @not_liked_question.id }
    assert Like.count == 2
    last = Like.last
    assert last.user == @me
    assert last.question == @not_liked_question
  end

  test 'does not allow me to like a question again' do
    post :create, :like => { :question_id => @liked_question.id }
    assert Like.count == 1
  end

  test 'allows me to unlike a question I liked before' do
    delete :destroy, :id => @like.id 
    assert Like.count == 0
  end
end
