require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  
  def setup
    @question = Question.new(quiz_id: 5,
                             prompt: "What time is it?",
                             correct_answer: "5pm",
                             answered: "false")
  end
  
  test "should be valid" do
    assert @question.valid?
  end
  
  test "should have a prompt" do
    @question.prompt = ""
    assert_not @question.valid?
  end
  
  test "should belong to quiz" do
    @question.quiz = nil
    assert_not @question.valid?
  end
  
  test "should have a correct answer" do
    @question.correct_answer = nil
    assert_not @question.valid?
  end
  
  test "answered should be true or false" do
    @question.answered = ""
    assert_not @question.valid?
  end

end