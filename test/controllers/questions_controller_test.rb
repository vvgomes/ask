require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:email => 'dude@tw.com')
    @question = Question.create(:user => @user,
      :description => 'Do you believe in God?')
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

  test 'shows a question' do
    get :show, :id => @question.id
    assert response.code == '200'
    assert assigns(:question) == @question
  end

  test 'provides a form to create a new question' do
    get :new
    assert response.code == '200'
    assert assigns(:question).new_record?
  end

  test 'creates a new question successfully' do
    post :create, :question => {
      :description => 'Why?'
    } 
    assert Question.count == 2
    last = Question.last
    assert last.user = @user
    assert last.description == 'Why?'
    assert_redirected_to question_path(last)
  end

  test 'does not create a question with invalid params' do
    post :create, :question => { :description => '' } 
    assert response.code == '200'
    assert Question.count == 1
  end

  test 'provides a form to edit an existing question' do
    get :edit, :id => @question.id
    assert response.code == '200'
    assert assigns(:question) == @question
  end

  test 'updates an existing question successfully' do
    put :update, :id => @question.id,
      :question => {
        :description => 'Do you believe in Buda?'
      } 
    assert Question.count == 1
    last = Question.last
    assert last.description == 'Do you believe in Buda?'
    assert_redirected_to question_path(last)
  end

  test 'does not update a question with invalid params' do
    put :update, :id => @question.id,
      :question => {
        :description => '' 
      } 
    assert response.code == '200'
    assert Question.count == 1
    last = Question.last
    assert last.description == 'Do you believe in God?'
  end

  test 'removes a question' do
    delete :destroy, :id => @question.id
    assert Question.count == 0
    assert_redirected_to questions_path
  end
end
