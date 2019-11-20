require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
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
  
end
