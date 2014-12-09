require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @me = User.create(:email => 'me@tw.com')
    @my_question = Question.create({
      :user => @me,
      :description => 'Do you believe in God?'
    })
    @dude = User.create(:email => 'dude@tw.com')
    @dude_question = Question.create({
      :user => @dude,
      :description => 'Do you believe in God?'
    })
    session[:user_id] = @me.id
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
    get :show, :id => @my_question.id
    assert response.code == '200'
    assert assigns(:question) == @my_question
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
    assert Question.count == 3
    last = Question.last
    assert last.user = @me
    assert last.description == 'Why?'
    assert_redirected_to question_path(last)
  end

  test 'does not create a question with invalid params' do
    post :create, :question => { :description => '' } 
    assert Question.count == 2
    assert response.code == '200'
  end

  test 'provides a form to edit an existing question' do
    get :edit, :id => @my_question.id
    assert response.code == '200'
    assert assigns(:question) == @my_question
  end

  test 'does not provide a form to edit a question from someone else' do
    get :edit, :id => @dude_question.id
    assert response.code == '403'
  end

  test 'updates an existing question successfully' do
    put :update, :id => @my_question.id,
      :question => {
        :description => 'Do you believe in Buda?'
      } 
    assert Question.count == 2
    updated = Question.find(@my_question.id)
    assert updated.description == 'Do you believe in Buda?'
    assert_redirected_to question_path(updated)
  end

  test 'does not update a question with invalid params' do
    put :update, :id => @my_question.id,
      :question => {
        :description => '' 
      } 
    assert Question.count == 2
    same = Question.find(@my_question.id)
    assert same.description == 'Do you believe in God?'
    assert response.code == '200'
  end

  test 'does not update a question from someone else' do
    put :update, :id => @dude_question.id,
      :question => {
        :description => '' 
      } 
    assert Question.count == 2
    same = Question.find(@my_question.id)
    assert same.description == 'Do you believe in God?'
    assert response.code == '403'
  end

  test 'removes a question' do
    delete :destroy, :id => @my_question.id
    assert Question.count == 1
    assert_redirected_to questions_path
  end

  test 'does not remove a question from someone else' do
    delete :destroy, :id => @dude_question.id
    assert Question.count == 2
    assert response.code == '403'
  end

  test 'gives me my questions' do
    get :mine
    assert assigns(:questions) == [@my_question]
    assert response.code == '200'
    assert_template :index
  end

  test 'gives me my favorite questions' do
    Like.create(:user => @me, :question => @dude_question)
    get :favorite
    assert assigns(:questions) == [@dude_question]
    assert response.code == '200'
    assert_template :index
  end
end
