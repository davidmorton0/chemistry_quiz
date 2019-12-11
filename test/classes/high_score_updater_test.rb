require 'test_helper'

class HighScoreUpdaterTest < ActiveSupport::TestCase

  def setup
    @answered_quiz = create(:new_quiz, :answered, :withscore)
    @answered_quiz_score = @answered_quiz.user.scores.first
    @unanswered_quiz = create(:new_quiz, :unanswered, :withscore)
    @unanswered_quiz_score = @unanswered_quiz.user.scores.first
    @timed_quiz = create(:new_quiz, :withscore)
    @timed_quiz_score = @timed_quiz.user.scores.first
  end
  
  test "updates high score for completed quiz" do
    #assert_not_equal @answered_quiz_score.reload.score, @answered_quiz.score
    HighScoreUpdater.new(@answered_quiz).call
    #assert_equal @answered_quiz_score.reload.score, @answered_quiz.score
  end

  test "doesn't update high score for incomplete quiz" do
    #assert_not_equal @unanswered_quiz_score.reload.score, @unanswered_quiz.score
    #HighScoreUpdater.new(@unanswered_quiz).call
    #assert_equal @unanswered_quiz_score.reload.score, @unanswered_quiz.score
  end
  
  test "adds high score for completed quiz with no existing high score" do
    @answered_quiz_score.destroy
    assert_empty Score.where(
      quiz_type: @answered_quiz.quiz_type,
      user_id: @answered_quiz.user)
    HighScoreUpdater.new(@answered_quiz).call
    assert_not_nil Score.where(
      quiz_type: @answered_quiz.quiz_type,
      user_id: @answered_quiz.user)
  end
  
  test "updates time for completed, faster quiz" do
    #assert_operator @timed_quiz_score.reload.fastest_time, :>, Time.now - @timed_quiz.created_at
    HighScoreUpdater.new(@timed_quiz).call
    #assert_not_equal @timed_quiz_score.fastest_time, @timed_quiz_score.reload.fastest_time
  end
  
  test "adds time for correct quiz with no existing fastest time" do
    assert_nil @answered_quiz_score.fastest_time
    HighScoreUpdater.new(@answered_quiz).call
    #assert_not_nil @answered_quiz_score.reload.fastest_time
  end
  
  test "doesn't update time for completed, slower quiz" do
    @timed_quiz_score.update(fastest_time: 100)
    assert_operator @timed_quiz_score.reload.fastest_time, :<, Time.now - @timed_quiz.created_at
    HighScoreUpdater.new(@timed_quiz).call
    assert_equal @timed_quiz_score.fastest_time, @timed_quiz_score.reload.fastest_time
  end
  
  test "doesn't update time for incomplete quiz" do
    assert_nil @unanswered_quiz_score.reload.fastest_time
    HighScoreUpdater.new(@unanswered_quiz).call
    assert_nil @unanswered_quiz_score.reload.fastest_time
  end
end