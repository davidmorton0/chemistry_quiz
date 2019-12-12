require 'test_helper'

class HighScoreUpdaterTest < ActiveSupport::TestCase

  test "updates high score for completed quiz" do
    @quiz = create(:quiz_10_questions, :correct, :with_score_5)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.score, 5
    HighScoreUpdater.new(@quiz).call
    assert_equal @score.reload.score, 10
  end

  test "doesn't update high score for incomplete quiz" do
    @quiz = create(:quiz_10_questions, :unanswered, :with_score_5)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.score, 5
    HighScoreUpdater.new(@quiz).call
    assert_equal @score.reload.score, @score.score
  end
  
  test "adds high score for completed quiz with no existing high score" do
    @quiz = create(:quiz_10_questions, :correct)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_nil @score
    HighScoreUpdater.new(@quiz).call
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.score, 10
  end
  
  test "updates time for completed, faster quiz" do
    @quiz = create(:quiz_10_questions, :correct, :with_score_10_10m)
    @quiz.update(created_at: 1.minute.ago)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.fastest_time, 600
    HighScoreUpdater.new(@quiz).call
    assert_equal @score.reload.fastest_time, 60
  end
  
  test "adds time for correct quiz with no existing fastest time" do
    @quiz = create(:quiz_10_questions, :correct, :with_score_5)
    @quiz.update(created_at: 1.minute.ago)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_nil @score.fastest_time
    HighScoreUpdater.new(@quiz).call
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.reload.fastest_time, 60
  end
  
  test "doesn't update time for completed, slower quiz" do
    @quiz = create(:quiz_10_questions, :correct, :with_score_10_10m)
    @quiz.update(created_at: 20.minutes.ago)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.fastest_time, 600
    HighScoreUpdater.new(@quiz).call
    assert_equal @score.reload.fastest_time, 600
  end
  
  test "doesn't update time for incomplete quiz" do
    @quiz = create(:quiz_10_questions, :unanswered, :with_score_10_10m)
    @score = Score.find_by(user: @quiz.user, quiz_type: @quiz.quiz_type)
    assert_equal @score.fastest_time, 600
    HighScoreUpdater.new(@quiz).call
    assert_equal @score.reload.fastest_time, 600
  end
end