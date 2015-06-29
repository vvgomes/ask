require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  setup do
    session[:user_id] = User.create(:email => 'u@thoughtworks.com').id
  end

  test 'shows home page' do
    get :index
    assert_redirected_to questions_path
  end
end
