require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest

  test "should get question index" do
    get questions_path
    assert_response :success
    assert_select "title", "Question Index#{@base_title}"
  end
  
  test "should show question" do
    q = 20
    get question_path(q)
    assert_response :success
    assert_select "title", "Question #{q}#{@base_title}"
  end
  
end
