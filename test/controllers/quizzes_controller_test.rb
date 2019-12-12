require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = create(:new_user, :admin)
    @non_admin = create(:new_user)
    @quiz = create(:new_quiz)
  end
  
  test "should get quiz index as admin" do
    log_in_as(@admin)
    get quizzes_path
    assert_response :success
    assert_select "title", "Quiz Index#{base_title}"
  end
  
  test "should redirect from quiz index as non-admin" do
    log_in_as(@non_admin)
    get quizzes_path
    assert_redirected_to root_path
  end

  test "should get current quiz" do
    log_in_as(@quiz.user)
    get quiz_path
    assert_response :success
    assert_template "show"
    assert_select "h1", @quiz.quiz_type.name
  end
  
  test "should redirect get quiz to login page for logged out user" do
    delete logout_path
    get quiz_path
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect to new quiz page for user without quiz" do
    log_in_as(@quiz.user)
    @quiz.destroy
    get quiz_path
    assert_redirected_to quiz_types_path
  end

  test "should view quiz through quiz view for admin" do
    log_in_as(@admin)
    get quiz_view_path(@quiz.id)
    assert_response :success
  end
  
  test "should redirect if trying to view quiz for non-admin" do
    log_in_as(@non_admin)
    get quiz_view_path(@quiz.id)
    assert_redirected_to root_path
  end
  
  test "should redirect to login page if logged out and trying to answer a question" do
    delete logout_path
    @question = create(:new_question)
    post_question_answer(@question, @question.correct_answer)
    assert_not @question.reload.answered
    assert_not flash.empty?
  end  
  
  test "should answer a question and reload" do
    @question = create(:new_question)
    log_in_as(@question.quiz.user)
    post_question_answer(@question, @question.correct_answer)
    assert @question.reload.answered
    assert_not flash.empty?
    assert_response :success
    assert_match (/location.reload/), response.body
  end
  
  test "should answer all questions and reload" do
    @quiz = create(:quiz_10_questions, :unanswered)
    log_in_as(@quiz.user)
    post_question_answers(@quiz, {})
    @quiz.questions.each do |question|
      assert question.answered
    end
    assert flash.empty?
    assert_response :success
    assert_match (/location.reload/), response.body
  end
end
