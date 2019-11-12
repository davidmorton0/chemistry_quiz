require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
  def setup
    @quiz = Quiz.new( title: "Test Quiz",
                      score: 0,
                      num_questions: 10,
                      user_id: 1 )
  end
  
  test "should be valid" do
    assert @quiz.valid?
  end
  
  test "should have title" do
    @quiz.title = ""
    assert_not @quiz.valid?
  end
  
  test "should belong to user" do
    @quiz.user_id = nil
    assert_not @quiz.valid?
  end
  
  test "score can't be less than 0" do
    @quiz.score = -1
    assert_not @quiz.valid?
  end
  
  test "must have at least one question" do
    @quiz.num_questions = 0
    assert_not @quiz.valid?
  end

end