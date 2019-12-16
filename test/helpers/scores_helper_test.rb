require 'test_helper'

class ScoresHelperTest < ActionView::TestCase
  include UsersHelper

  test "gets score info from quiz" do
    score = 8
    fastest_time = 30
    num_questions = 12
    user_name = "Name"
    @score = create(:new_score, score: score, fastest_time: fastest_time)
    @score.quiz_type.update(num_questions: num_questions)
    @score.user.update(name: user_name)
    @high_score = high_score(@score.quiz_type)
    assert_equal @high_score[0], "#{score} / #{num_questions}"
    assert_equal @high_score[1], "#{fastest_time}s"
    assert_equal @high_score[2], user_name
  end

  test "gets blank score info when no score" do
    score = 8
    fastest_time = 30
    num_questions = 12
    user_name = "Name"
    @score = create(:new_score, score: score, fastest_time: fastest_time)
    @score.quiz_type.update(num_questions: num_questions)
    @score.user.update(name: user_name)
    @score.destroy
    @high_score = high_score(@score.quiz_type)
    assert_equal @high_score[0], "-"
    assert_nil @high_score[1]
    assert_equal @high_score[2], "-"
  end
  
  test "gets score info when no fastest time" do
    score = 8
    fastest_time = nil
    num_questions = 12
    user_name = "Name"
    @score = create(:new_score, score: score, fastest_time: fastest_time)
    @score.quiz_type.update(num_questions: num_questions)
    @score.user.update(name: user_name)
    @high_score = high_score(@score.quiz_type)
    assert_equal @high_score[0], "#{score} / #{num_questions}"
    assert_equal @high_score[1], "-"
    assert_equal @high_score[2], user_name
  end
  
  test "gets highest score" do
    num_questions = 8
    high_score = 7
    @quiz_type = create(:new_quiz_type, num_questions: num_questions)
    score = create(:new_score, score: high_score - 2)
    score.update(quiz_type: @quiz_type)
    score = create(:new_score, score: high_score, quiz_type: @quiz_type)
    score.update(quiz_type: @quiz_type)
    score = create(:new_score, score: high_score - 4, quiz_type: @quiz_type)
    score.update(quiz_type: @quiz_type)
    @high_score = high_score(@quiz_type)
    assert_equal @high_score[0], "#{high_score} / #{num_questions}"
  end
  
  test "gets fastest time from max scores" do
    num_questions = 8
    high_score = 8
    fastest_time = 30
    @quiz_type = create(:new_quiz_type, num_questions: num_questions)
    score = create(:new_score, score: high_score, fastest_time: fastest_time)
    score.update(quiz_type: @quiz_type)
    score = create(:new_score, score: high_score, fastest_time: fastest_time + 10)
    score.update(quiz_type: @quiz_type)
    score = create(:new_score, score: high_score, fastest_time: fastest_time + 100)
    score.update(quiz_type: @quiz_type)
    @high_score = high_score(@quiz_type)
    assert_equal @high_score[0], "#{high_score} / #{num_questions}"
    assert_equal @high_score[1], "#{fastest_time}s"
  end
  
  test "gets highest score from different quiz types" do
    num_questions = 8
    high_score = 7
    @quiz_type = create(:new_quiz_type, num_questions: num_questions)
    @quiz_type2 = create(:new_quiz_type, num_questions: num_questions)
    score = create(:new_score, score: high_score)
    score.update(quiz_type: @quiz_type)
    score = create(:new_score, score: high_score - 1)
    score.update(quiz_type: @quiz_type)
    score = create(:new_score, score: high_score - 2)
    score.update(quiz_type: @quiz_type2)
    assert_equal high_score(@quiz_type)[0], "#{high_score} / #{num_questions}"
    assert_equal high_score(@quiz_type2)[0], "#{high_score - 2} / #{num_questions}"
  end
end