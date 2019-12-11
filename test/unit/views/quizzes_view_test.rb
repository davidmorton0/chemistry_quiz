require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
=begin
  def setup
    @admin = create(:admin)
    @non_admin = create(:user)
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
  
  test "should show buttons for different level tests" do
    log_in_as(@quiz.user)
    get quiz_type_path(@quiz.quiz_type.id)
    follow_redirect!
    assert_select "a.btn.btn-lg.btn-primary.level.l1", count: 1
    #assert_select "a.btn.btn-lg.btn-primary.level.l2", count: 1
  end
=end
end
