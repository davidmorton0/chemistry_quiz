require 'test_helper'

class QuizzesIndexTest < ActionDispatch::IntegrationTest
  
  test "should show quizzes index" do
    @quiz = create(:new_quiz)
    20.times do
      create(:new_quiz)
    end
    @user = create(:new_user, :admin)
    log_in_as(@user)
    get quizzes_path
    assert_select "title", "Quiz Index#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "Quizzes"
      assert_select "a[href=?]", quizzes_path(page: 2), count: 4
      assert_select "table" do
        assert_select "tr", count: 11
        assert_select "tr:nth-child(1)" do
          assert_select "th", "ID"
          assert_select "th", "Name"
          assert_select "th", "Level"
          assert_select "th", "Difficulty"
          assert_select "th", "Number of Questions"
          assert_select "th", "User"
          assert_select "th", "Score"
          assert_select "th", ""
        end
        assert_select "tr:nth-child(2)" do
          assert_select "td", @quiz.id.to_s
          assert_select "td", @quiz.quiz_type.name
          assert_select "td", @quiz.quiz_type.level.to_s
          assert_select "td", @quiz.quiz_type.difficulty.to_s
          assert_select "td", @quiz.quiz_type.num_questions.to_s
          assert_select "td", @quiz.user.name
          assert_select "td", @quiz.score.to_s
          assert_select "td", 'Show'do
            assert_select "a[href=?]", quiz_view_path(@quiz.id)
          end
        end
      end
    end
  end
end
