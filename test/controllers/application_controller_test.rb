require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  setup do
    session[:user_id] = User.create(:email => 'dude@tw.com')
  end

  test 'shows home page' do
    get :index
    assert response.code == '200'
    assert_template :index
  end
end
