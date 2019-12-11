require 'test_helper'

class QuestionsViewTest < ActionDispatch::IntegrationTest
=begin
  def setup
    @admin = create(:new_user, :admin)
    @non_admin = create(:new_user)
  end
  
  test "should get question index as admin" do
    log_in_as(@admin)
    get questions_path
    assert_response :success
    assert_select "title", "Question Index#{base_title}"
  end
  
  test "should redirect from question index as non_admin" do
    log_in_as(@non_admin)
    get questions_path
    assert_redirected_to root_url
  end
  
  test "should show question" do
    quiz = create(:new_quiz, :unanswered)
    log_in_as(@admin)
    @question = quiz.questions.first
    get question_path(@question.id)
    assert_response :success
    assert_select "title", "Question #{@question.id}#{base_title}"
    assert_select "p", "Question ID: #{@question.id}"
    assert_select "p", "Quiz ID: #{@question.quiz_id}"
    assert_select "p", "Prompt: #{@question.prompt}"
    assert_select "p", "Question ID: #{@question.id}"
    assert_select "ul.answer" do
      assert_select "li", 4
    end
    assert_select "p", "Correct Answer: #{@question.correct_answer}"
    assert_select "p", "Answered: #{@question.answered}"
  # assert_select "p", "Chosen Answer: #{@question.chosen_answer}"
  end
  
  test "should redirect from question as non_admin" do
    quiz = create(:new_quiz, :unanswered)
    log_in_as(@non_admin)
    @question = quiz.questions.first
    get question_path(@question.id)
    assert_redirected_to root_url
  end
=end
end