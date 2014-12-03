require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    Question.delete_all
    User.delete_all
    @user = User.create(:email => 'dude@tw.com')
    @question = Question.create(:user => @user)
    session[:user_id] = @user.id
  end

  test 'displays a form to create a new question' do
    get :new
    assert response.code == '200'
    assert assigns(:question).new_record?
  end

  test 'creates a new key for user successfully' do
    post :create, :question => {
      :description => 'What is the best way to sort an array?'
    } 
    assert Question.count == 2
    last = Question.last
    assert last.user = @user
    assert last.description == 'What is the best way to sort an array?'
    assert_redirected_to question_path(last)
  end
end
