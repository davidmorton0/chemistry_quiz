require 'test_helper'

class QuestionsIndexTest < ActionDispatch::IntegrationTest
  
  test "should show questions index" do
    @quiz = create(:quiz_10_questions, :correct)
    create(:quiz_10_questions, :correct)
    create(:quiz_10_questions, :correct)
    @question = @quiz.questions.first
    @user = create(:new_user, :admin)
    log_in_as(@user)
    get questions_path
    assert_select "title", "Question Index#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "Questions"
      assert_select "a[href=?]", questions_path(page: 2), count: 4
      assert_select "table" do
        assert_select "tr", count: 21
        assert_select "tr:nth-child(1)" do
          assert_select "th", "ID"
          assert_select "th", "Quiz Type"
          assert_select "th", "Quiz ID"
          assert_select "th", "Prompt"
          assert_select "th", ""
        end
        assert_select "tr:nth-child(2)" do
          assert_select "td", @question.id.to_s
          assert_select "td", @question.quiz.quiz_type.name
          assert_select "td", @question.quiz.id.to_s
          assert_select "td", @question.prompt
          assert_select "td", 'Show'do
            assert_select "a[href=?]", question_path(@question)
          end
        end
      end
    end
  end
end
