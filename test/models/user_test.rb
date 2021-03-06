require 'test_helper'

class UserTest < ActiveSupport::TestCase
  teardown do
    User.delete_all
  end

  test 'must have an email to be valid' do
    assert !User.new.valid?
    assert User.new(:email => 'u@thoughtworks.com').valid?
  end

  test 'must have a valid email' do
    assert !User.new(:email => 'u').valid?
  end

  test 'cannot have the same email as an existing user' do
    User.create(:email => 'u@thoughtworks.com')
    assert !User.new(:email => 'u@thoughtworks.com').valid?
  end

  test 'cannot have a non-thoughtworks email' do
    assert !User.new(:email => 'u@gmail.com').valid?
  end

  test 'is created from omniauth' do
    User.from_omniauth({ :extra => { :raw_info => { :email => 'u@thoughtworks.com' } } })
    assert User.last.email == 'u@thoughtworks.com'
    assert User.count == 1
  end

  test 'is found by email' do
    User.create(:email => 'u@thoughtworks.com')
    user = User.from_omniauth({ :extra => { :raw_info => { :email => 'u@thoughtworks.com' } } })
    assert User.last.email == 'u@thoughtworks.com'
    assert User.count == 1
  end

  test 'has many questions' do
    author = User.new
    question = Question.new(:user => author)
    author.questions << question 
    assert author.questions == [question]
  end

  test 'has a username based on email' do
    user = User.new(:email => 'u@thoughtworks.com')
    assert user.username == 'u'
  end

  test 'has many likes' do
    like = Like.new
    user = User.new
    user.likes << like
    assert user.likes == [like]
  end

  test 'knows about a question she does not like' do
    assert !User.new.likes?(Question.new)
  end

  test 'knows about a question she likes' do
    user = User.create(:email => 'u@thoughtworks.com')
    question = Question.create(:description => 'Why?', :user => user)
    Like.create(:user => user, :question => question)
    assert user.likes?(question)
  end
end
