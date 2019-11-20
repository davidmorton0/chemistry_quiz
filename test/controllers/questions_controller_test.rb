require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest

  test "should get question index" do
    get questions_path
    assert_response :success
    assert_select "title", "Question Index#{@base_title}"
  end
  
  test "should show question" do
    @question = Question.first
    get question_path(@question.id)
    assert_response :success
    assert_select "title", "Question #{@question.id}#{@base_title}"
  end
  
end
