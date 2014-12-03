require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'belongs to an user' do
    author = User.new
    question = Question.new(:user => author)
    assert question.user == author
  end
end
