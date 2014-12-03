require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'belongs to an user' do
    author = User.new
    question = Question.new(:user => author)
    assert question.user == author
  end

  test 'cannot be valid without an user' do
    assert !Question.new.valid?
    assert Question.new(:user => User.new).valid?
  end
end
