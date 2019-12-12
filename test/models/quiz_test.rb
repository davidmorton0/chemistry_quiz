require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
  def setup
    @quiz = create(:new_quiz)
  end
  
  test "should be valid" do
    assert @quiz.valid?
  end
  
  test "should have quiz type" do
    @quiz.quiz_type_id = nil
    assert_not @quiz.valid?
  end
  
  test "should belong to user" do
    @quiz.user_id = nil
    assert_not @quiz.valid?
  end
  
  test "should have a score >= 0" do
    @quiz.score = nil
    assert_not @quiz.valid?
    @quiz.score = -1
    assert_not @quiz.valid?
  end

end