require 'test_helper'

class ScoresIndexTest < ActionDispatch::IntegrationTest
  
  test "should show high scores index" do
    20.times do
      create(:new_score, score: 8, fastest_time: 100)
    end
    @quiz_type = QuizType.all.first
    @score = Score.all.first
    get scores_path
    assert_select "title", "High Scores#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "High Scores"
      assert_select "a[href=?]", scores_path(page: 2), count: 4
      assert_select "div.row" do
        assert_select "div.col-md-12" do
          assert_select "table.highscoretable" do
            assert_select "colgroup" do
              assert_select "col", count: 6
            end
            assert_select "tr", count: 6
            assert_select "tr:nth-child(2)" do
              assert_select "th", "Quiz"
              assert_select "th", "Level"
              assert_select "th", "Difficulty"
              assert_select "th", "High Score"
              assert_select "th", "Fastest time"
              assert_select "th", "User"
            end
            assert_select "tr:nth-child(3)" do
              assert_select "td", @quiz_type.name
              assert_select "td", @quiz_type.level.to_s
              assert_select "td", @quiz_type.difficulty.to_s
              assert_select "td:nth-child(4)", "8 / 10"
              assert_select "td:nth-child(5)", "1m 40s"
              assert_select "td:nth-child(6)", @score.user.name
            end
          end
        end
      end
    end
  end
end
