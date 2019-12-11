require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @quiz_type = create(:quiz_type)
    @user = create(:user)
    @quiz = create(:quiz)
    @question = create(:question)
    @answer = Answer.new(text: "C",
                question_id: @question.id)
  end
  
  test "should be valid" do
    assert @answer.valid?
  end
  
  test "should have text" do
    @answer.text = ""
    assert_not @answer.valid?
  end
  
  test "should belong to question" do
    @answer.question = nil
    assert_not @answer.valid?
  end
end
