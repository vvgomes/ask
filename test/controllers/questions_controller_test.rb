require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:email => 'dude@tw.com')
    session[:user_id] = @user.id
  end

  teardown do
    Question.delete_all
    User.delete_all
  end

  test 'lists all the questions' do
    get :index
    assert response.code == '200'
    assert assigns(:questions)
  end

  test 'provides a form to create a new question' do
    get :new
    assert response.code == '200'
    assert assigns(:question).new_record?
  end

  test 'creates a new question for user successfully' do
    post :create, :question => {
      :description => 'Do you believe in god?'
    } 
    last = Question.last
    assert last.user = @user
    assert last.description == 'Do you believe in god?'
    assert_redirected_to question_path(last)
  end
end
