require 'users_helper'

class ScoresHelperTest < ActionView::TestCase
  include UsersHelper

  test "gets score info from quiz" do
    @quiz_type = quiz_types(:two)
    @score = scores(:one)
    @high_score = high_score(@quiz_type)
    assert_equal @high_score[0], "#{@score.score} / #{@quiz_type.num_questions}"
    assert_equal @high_score[1], format_time(@score.fastest_time)
    assert_equal @high_score[2], @score.user.name
  end

  test "gets blank score info when no score" do
    @high_score = high_score(quiz_types(:no_high_score_quiz))
    assert_equal @high_score[0], "-"
    assert_nil @high_score[1]
    assert_equal @high_score[2], "-"
  end
end