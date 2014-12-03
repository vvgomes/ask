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
end
