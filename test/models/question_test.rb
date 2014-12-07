require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'belongs to an user' do
    author = User.new
    q = Question.new(:user => author)
    assert q.user == author
  end

  test 'must have a description' do
    q = Question.new(:user => User.new)
    assert !q.valid?
    q.description = 'Do you believe in god?'
    assert q.valid?
  end

  test 'has many likes' do
    like = Like.new
    q = Question.new
    q.likes << like
    assert q.likes == [like]
  end
end
