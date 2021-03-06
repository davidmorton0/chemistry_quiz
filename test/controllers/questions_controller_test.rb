require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest

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
  
  test "should show question as admin" do
    @question = create(:new_question)
    log_in_as(@admin)
    get question_path(@question.id)
    assert_response :success
    assert_select "title", "Question #{@question.id}#{base_title}"
  end
  
  test "should redirect from question as non_admin" do
    @question = create(:new_question)
    log_in_as(@non_admin)
    get question_path(@question.id)
    assert_redirected_to root_url
  end
end