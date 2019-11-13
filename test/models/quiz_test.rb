require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
  def setup
    @quiz = Quiz.new( title: "Test Quiz",
                      score: 0,
                      user_id: 1,
                      difficulty: 3)
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

  test "difficulty must be greater than 0" do
    @quiz.difficulty = 0
    assert_not @quiz.valid?
  end
  
  test "difficulty must be less than or equal to 10" do
    @quiz.difficulty = 11
    assert_not @quiz.valid?
  end

end