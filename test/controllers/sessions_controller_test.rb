require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    User.delete_all
    @dude = User.create(:email => 'u@thoughtworks.com')
  end

  test '#create' do
    auth = { 'omniauth.auth' => { :extra => { :raw_info => { :email => 'u@thoughtworks.com' } } } }
    SessionsController.any_instance.stubs(:env).returns(auth)
    get :create, :provider => :google_oauth2
    assert response.code == '302'
    assert session[:user_id] == @dude.id
  end

  test '#destoy' do
    get :destroy
    assert response.code == '302'
    assert session[:user_id].nil?
  end
end
