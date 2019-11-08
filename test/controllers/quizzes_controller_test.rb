require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest

=begin
  test "should get quiz start page" do
    get quiz_path
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_match "1. What is the chemical symbol for", response.body
    assert_select "input[type=?]", 'radio', count: 4
    assert_select "input[type=?]", 'submit', count: 1
  end
  
  test "should show results at end of test" do
    post quiz_path,
      params: { quiz: {"question_number"=>"10", "page"=>"answer", "score"=>"2"} }
    assert_response :success
    assert_no_match '✔️', response.body
    assert_no_match '❌', response.body
    assert_select "input[type=?]", 'radio', count: 0
    assert_match 'You scored 2 out of 10', response.body
  end
  
    test "gets question data" do
    @question_data = question_data
    assert_match "What is the chemical symbol for", question_data[:question]
    question_data[:answers].each do |answer|
      assert answer.length > 0
      assert answer.length < 3
      assert_match /[A-Z][a-z]?/, answer
    end
  end
=end
end
