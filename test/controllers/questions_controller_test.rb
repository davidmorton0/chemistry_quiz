require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  
  #setup
  
  test "should get question index" do
    get questions_path
    assert_response :success
    assert_select "title", "Question Index#{@base_title}"
  end
=begin
  test "should show question" do
    get question_path(1)
    assert_response :success
    assert_select "title", "Question#{@base_title}"
  end
=end

end
