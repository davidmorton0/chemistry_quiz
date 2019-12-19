require 'test_helper'

class QuizTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get quiz type index" do
    get quiz_types_path
    assert_response :success
    assert_select "title", "Choose a Quiz#{base_title}"
  end
  
  test "should redirect to quiz when quiz_type selected" do
    @user = create(:user)
    @quiz_type = create(:new_quiz_type)
    log_in_as @user
    get quiz_type_path(@quiz_type.id)
    assert_redirected_to quiz_path
  end
  
  test "should redirect to login when quiz_type selected and not logged in" do
    @quiz_type = create(:new_quiz_type)
    get quiz_type_path(@quiz_type.id)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should create new quiz" do
    @quiz = create(:new_quiz)
    @quiz.quiz_type.update(name: "Chemical Symbol Quiz")
    @user = @quiz.user
    log_in_as(@user)
    get quiz_type_path(@quiz.quiz_type.id)
    assert_not_equal @quiz.created_at, @user.reload.quiz.created_at
    assert flash.empty?
    assert_redirected_to quiz_path
  end
end
