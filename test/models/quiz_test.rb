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

  test "should answer a quiz correctly" do
    quiz = create(:quiz_10_questions, :unanswered)
    assert_equal quiz.score, 0
    answers = {}
    quiz.questions.each{|question| answers[question.id.to_s] = question.correct_answer}
    quiz.answer(answers)
    assert_equal quiz.reload.score, 10
  end
  
  test "should answer a quiz incorrectly" do
    quiz = create(:quiz_10_questions, :unanswered)
    assert_equal quiz.score, 0
    answers = {}
    quiz.questions.each{|question| answers[question.id.to_s] = ""}
    quiz.answer(answers)
    assert_equal quiz.reload.score, 0
  end
  
  test "should update high score" do
    quiz = create(:quiz_10_questions, :correct, :with_score_5)
    assert_equal quiz.score, 10
    quiz.update_high_score
    score = Score.find_by(user_id: quiz.user_id,
                          quiz_type_id: quiz.quiz_type_id)
    assert_equal score.score, 10
  end
end