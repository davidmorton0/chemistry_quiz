require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get current quiz start page" do
    get quiz_url
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_match "1. What is the chemical symbol for", response.body
    assert_select "input[type=?]", 'radio', count: 12
    assert_select "input[type=?]", 'submit', count: 4
    assert_equal Quiz.first.id, 5
    assert_equal Quiz.first.num_questions, 3
    assert_equal Quiz.first.score, 1
    assert_equal questions.first.id, 20
    assert_equal questions.second.id, 21
    assert_equal questions.third.id, 22
  end

  test "should start new quiz" do
    get new_quiz_url
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_match "1. What is the chemical symbol for", response.body
    assert_select "input[type=?]", 'radio', count: 40
    assert_select "input[type=?]", 'submit', count: 11
    assert_equal Quiz.first.id, 1
  end
=begin
  test "should create new quiz for new user" do
                                      #select new user needed
    get quiz_url
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_match "1. What is the chemical symbol for", response.body
    assert_select "input[type=?]", 'radio', count: 40
    assert_select "input[type=?]", 'submit', count: 11
    assert_equal Quiz.first.id, 1
  end
=end

end
