require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  setup do
    session[:user_id] = User.create(:email => 'dude@tw.com')
  end

  test 'shows home page' do
    get :index
    assert_redirected_to questions_path
  end
end
