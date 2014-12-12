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

  test 'does not accept a question with more than 140 chars' do
    long_description = 141.times.map{'x'}.join
    q = Question.new(:user => User.new, :description => long_description)
    assert !q.valid?
  end
end
