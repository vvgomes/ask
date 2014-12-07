require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  teardown do
    Like.delete_all
    User.delete_all
    Question.delete_all
  end

  test 'must have an user and a question' do
    assert !Like.new.valid?
    assert !Like.new(:user => User.new).valid?
    assert !Like.new(:question => Question.new).valid?
    assert Like.new(:user => User.new, :question => Question.new).valid?
  end

  test 'cannot have a duplicated user-question combination' do
    u = User.create(:email => 'dude@tw.com')
    q = Question.create(:description => 'Why?', :user => u)
    Like.create(:user => u, :question => q)
    assert !Like.new(:user => u, :question => q).valid?
  end
end
