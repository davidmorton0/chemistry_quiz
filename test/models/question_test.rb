require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  
  def setup
    @question = create(:new_question)
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
  
  test "should answer a question correctly" do
    assert_not @question.answered
    assert_nil @question.chosen_answer
    assert_difference '@question.quiz.score' do
      @question.answer_question(@question.correct_answer)
      @question.reload
    end
    assert @question.answered
    assert_equal @question.chosen_answer, @question.correct_answer
  end
  
  test "should answer a question incorrectly" do
    assert_not @question.answered
    assert_nil @question.chosen_answer
    assert_no_difference '@question.quiz.score' do
      @question.answer_question("Wrong")
      @question.reload
    end
    assert @question.answered
    assert_not_nil @question.chosen_answer
  end

  test "should not answer an answered question" do
    @question.update(answered: true, chosen_answer: "Answer")
    assert @question.answered
    assert_not_nil @question.chosen_answer
    assert_no_difference '@question.quiz.score' do
      @question.answer_question(@question.correct_answer)
      @question.reload
    end
    assert @question.answered
    assert_not_equal @question.chosen_answer, @question.correct_answer
  end
end