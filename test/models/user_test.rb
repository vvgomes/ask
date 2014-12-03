require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'must have an email to be valid' do
    assert !User.new.valid?
    assert User.new(:email => 'u@tw.com').valid?
  end

  test 'must have a valid email' do
    skip
    assert !User.new(:email => 'u').valid?
  end

  test 'is created from omniauth' do
    User.delete_all
    User.from_omniauth({:uid => 'dude@tw.com'})
    assert User.last.email == 'dude@tw.com'
    assert User.count == 1
  end

  test 'is found by email' do
    User.delete_all
    User.create(:email => 'dude@tw.com')
    user = User.from_omniauth({:uid => 'dude@tw.com'})
    assert user.email == 'dude@tw.com'
    assert User.count == 1
  end
end
