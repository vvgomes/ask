require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    User.delete_all
    @dude = User.create(:email => 'dude@tw.com')
  end

  test '#create' do
    auth = { 'omniauth.auth' => { :uid => 'dude@tw.com' } }
    SessionsController.any_instance.stubs(:env).returns(auth)
    get :create, :provider => :saml
    assert response.code == '302'
    assert session[:user_id] == @dude.id
  end

  test '#destoy' do
    get :destroy
    assert response.code == '302'
    assert session[:user_id].nil?
  end
end
