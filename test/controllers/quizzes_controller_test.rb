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
    assert_no_difference 'Quiz.count' do
      get quiz_path
      assert_response :success
      assert_template "show"
      assert_select "h1", @quiz.quiz_type.name
    end
  end

  test "should start new quiz" do
    @user = @quiz.user
    log_in_as(@user)
    assert_no_difference 'Quiz.count' do
      get quiz_type_path(@quiz.quiz_type)
      assert_redirected_to quiz_path
      follow_redirect!
      assert_template "show"
      assert_select "h1", @quiz.quiz_type.name
    end
    assert_not_equal @user.quiz.created_at, @user.reload.quiz.created_at
  end

  test "should redirect from resume quiz to new quiz page for user without quiz" do
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

  test "should answer a question correctly and reload" do
    @question = create(:new_question)
    log_in_as(@question.quiz.user)
    answer_question(@question, @question.correct_answer)
    assert @question.reload.answered
    assert_not flash.empty?
    assert_response :success
    assert_match (/location.reload/), response.body
  end
  
  test "should answer all questions incorrectly and reload" do
    @quiz = create(:quiz_10_questions, :unanswered)
    log_in_as(@quiz.user)
    answer_questions(@quiz, {})
    @quiz.questions.each do |question|
      assert question.answered
    end
    assert flash.empty?
    assert_response :success
    assert_match (/location.reload/), response.body
  end
end
