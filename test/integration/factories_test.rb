require 'test_helper'

class FactoriesTest < ActionDispatch::IntegrationTest
  
  test "should create a valid answer" do
    answer = create(:new_answer)
    assert answer.valid?
  end
  
  test "should create a valid question" do
    question = create(:new_question)
    assert question.valid?
  end
  
  test "should create a valid quiz" do
    quiz = create(:new_quiz)
    assert quiz.valid?
  end
  
  test "should create a valid quiz_type" do
    quiz_type = create(:new_quiz_type)
    assert quiz_type.valid?
  end

  test "should create a valid score" do
    score = create(:new_score)
    assert score.valid?
    assert_equal score.score, 0
  end
  
  test "should create a valid non-admin user" do
    user = create(:new_user)
    assert user.valid?
    assert_not user.admin
  end
  
  test "users should have different names and emails" do
    user1 = create(:new_user)
    user2 = create(:new_user)
    assert_not_equal user1.email, user2.email
    assert_not_equal user1.name, user2.name
  end
  
  test "should create a valid admin user" do
    user = create(:new_user, :admin)
    assert user.valid?
    assert user.admin
  end
  
  test "should create a valid not activated user" do
    user = create(:new_user, :not_activated)
    assert user.valid?
    assert_not user.activated
  end
  
  test "should create a 10 question, unanswered quiz, each question has 4 answers" do
    quiz = create(:quiz_10_questions, :unanswered)
    assert quiz.valid?
    assert_equal quiz.questions.count, 10
    assert_equal quiz.score, 0
    quiz.questions.each do |question|
      assert_not_nil question.correct_answer
      assert_nil question.chosen_answer
      assert_equal question.answers.count, 4
      assert_not question.answered
      assert_equal question.answers.select{ |answer| question.correct_answer == answer.text}.count, 1
      assert_equal question.answers.select{ |answer| question.correct_answer != answer.text}.count, 3
    end  
  end
  
  test "should create a 10 question, answered quiz, all incorrect" do
    quiz = create(:quiz_10_questions, :incorrect)
    assert quiz.valid?
    assert_equal quiz.questions.count, 10
    assert_equal quiz.score, 0
    quiz.questions.each do |question|
      assert_not_nil question.correct_answer
      assert_not_nil question.chosen_answer
      assert_equal question.answers.count, 4
      assert question.answered
      assert_equal question.answers.select{ |answer| question.correct_answer == answer.text}.count, 1
      assert_equal question.answers.select{ |answer| question.correct_answer != answer.text}.count, 3
      assert_not_equal question.correct_answer, question.chosen_answer
    end  
  end
  
  test "should create a 10 question, answered quiz, all correct" do
    quiz = create(:quiz_10_questions, :correct)
    assert quiz.valid?
    assert_equal quiz.questions.count, 10
    assert_equal quiz.score, 10
    quiz.questions.each do |question|
      assert_not_nil question.correct_answer
      assert_not_nil question.chosen_answer
      assert_equal question.answers.count, 4
      assert question.answered
      assert_equal question.answers.select{ |answer| question.correct_answer == answer.text}.count, 1
      assert_equal question.answers.select{ |answer| question.correct_answer != answer.text}.count, 3
      assert_equal question.correct_answer, question.chosen_answer
    end  
  end
  
  test "should create a score of 5, no fastest time" do
    score = create(:new_score, :score_5)
    assert score.valid?
    assert_equal score.score, 5
    assert_nil score.fastest_time
  end
  
  test "should create a score of 10, 5 min fastest time" do
    score = create(:new_score, :score_10_5_min)
    assert score.valid?
    assert_equal score.score, 10
    assert_equal score.fastest_time, 300
  end
  
  test "should create a score of 10, 1 min fastest time" do
    score = create(:new_score, :score_10_1_min)
    assert score.valid?
    assert_equal score.score, 10
    assert_equal score.fastest_time, 60
  end
end