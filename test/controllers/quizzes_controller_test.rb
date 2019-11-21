require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "should get quiz index as admin" do
    log_in_as(@admin)
    get quiz_index_path
    assert_response :success
    assert_select "title", "Quiz Index#{base_title}"
  end
  
  test "should redirect from quiz index as non-admin" do
    log_in_as(@non_admin)
    get quiz_index_path
    assert_redirected_to root_path
  end
  
  test "should view quiz through quiz view for admin" do
    log_in_as(@non_admin)
    get quiz_type_path(quiz_types(:one).id)
    @quiz = Quiz.find_by(user_id: @non_admin.id)
    log_in_as(@admin)
    get quiz_view_path(@quiz.id)
    assert_response :success
  end
  
  test "should redirect if trying to view quiz for non-admin" do
    log_in_as(@non_admin)
    @quiz = Quiz.find_by(user_id: @admin.id)
    get quiz_view_path(@quiz.id)
    assert_redirected_to root_path
  end
  
  test "should get current quiz" do
    @user = users(:michael)
    log_in_as(@user)
    assert_no_difference 'Quiz.count' do
      get quiz_path
      assert_response :success
      assert_template "show"
      assert_select "h1", @user.quiz.quiz_type.name
      assert_select "input[type=?]", 'radio', count: @user.quiz.answers.count
      assert_select "p", "1. #{@user.quiz.questions.first.prompt}"
      assert_select "button[type=?]", 'submit', count: @user.quiz.questions.count + 1
    end
  end

  test "should start new quiz" do
    @user = users(:michael)
    log_in_as(@user)
    @quiz_type = quiz_types(:one)
    assert_no_difference 'Quiz.count' do
      get quiz_type_path(@quiz_type.id)
      assert_redirected_to quiz_path
      follow_redirect!
      assert_template "show"
      assert_select "h1", @user.quiz.quiz_type.name
      assert_select "input[type=?]", 'radio', count: @user.quiz.answers.count
      assert_select "p", "1. #{@user.quiz.questions.first.prompt}"
      assert_select "button[type=?]", 'submit', count: @user.quiz.questions.count + 1
    end
  end

  test "should redirect from resume quiz to new quiz page for new user" do
    @user = users(:mary)
    log_in_as(@user)
    get quiz_path
    assert_redirected_to quiz_types_path
  end
  
  test "should show buttons for different level tests" do
    @user = users(:michael)
    log_in_as(@user)
    get quiz_type_path(1)
    follow_redirect!
    assert_select "a.btn.btn-lg.btn-primary.level.l1", count: 0
    assert_select "a.btn.btn-lg.btn-primary.level.l2", count: 1
  end
end
