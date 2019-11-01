require 'test_helper'
class ChemPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = " | Chemistry Quiz"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About#{@base_title}"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact#{@base_title}"
  end
  
  test "should get quiz start page" do
    get quiz_path
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_select "p", "1. What is the chemical symbol for Hydrogen?"
    assert_match ' C', response.body
    assert_select "input[type=?]", 'radio', count: 4
    assert_select "input[type=?]", 'hidden', count: 3
    assert_select "input[type=?]", 'submit', count: 1
  end

  test "should post answer to first quiz question" do
    post quiz_path,
      params: { "answer"=>"C", quiz: {"question_number"=>"1", "page"=>"question", "score"=>"0"} }
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_select "p", "1. What is the chemical symbol for Hydrogen?"
    assert_match 'H✔️', response.body
    assert_match 'C❌', response.body
    assert_select "input[type=?]", 'radio', count: 4
    assert_select "input[type=?]", 'hidden', count: 3
    assert_select "input[type=?]", 'submit', count: 1
    assert_select "input[value=?]", '0', count: 1
  end

end
