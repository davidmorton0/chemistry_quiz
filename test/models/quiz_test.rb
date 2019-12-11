require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
  def setup
    @quiz_type = create(:quiz_type)
    @user = create(:user)
    @quiz = Quiz.new( score: 0,
                      user_id: @user.id,
                      quiz_type_id: @quiz_type.id)
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
  
  test "score can't be less than 0" do
    @quiz.score = -1
    assert_not @quiz.valid?
  end

end