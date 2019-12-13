require 'test_helper'

class QuizTypeTest < ActiveSupport::TestCase
  def setup
    @quiz_type = create(:new_quiz_type)
  end
  
  test "should be valid" do
    assert @quiz_type.valid?
  end
  
  test "should have name" do
    @quiz_type.name = nil
    assert_not @quiz_type.valid?
  end
  
  test "should have number of questions >= 0" do
    @quiz_type.num_questions = nil
    assert_not @quiz_type.valid?
    @quiz_type.num_questions = -1
    assert_not @quiz_type.valid?
  end
  
  test "should have a difficulty >= 0" do
    @quiz_type.difficulty = nil
    assert_not @quiz_type.valid?
    @quiz_type.difficulty = -1
    assert_not @quiz_type.valid?
  end
  
  test "should have a level >= 0" do
    @quiz_type.level = nil
    assert_not @quiz_type.valid?
    @quiz_type.level = -1
    assert_not @quiz_type.valid?
  end
  
  test "should have a description" do
    @quiz_type.description = nil
    assert_not @quiz_type.valid?
  end
end
