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
    assert_match "1. What is the chemical symbol for", response.body
    assert_select "input[type=?]", 'radio', count: 4
    assert_select "input[type=?]", 'submit', count: 1
  end

  test "should post incorrect answer to question" do
    post quiz_path,
    params: {
        "answer"=>"C",
        "quiz" => {
          "question_number"=>"1",
          "page"=>"question",
          "score"=>"0",
          "question"=>"What is the chemical symbol for Hydrogen?",
          "answer_A"=>"C",
          "answer_B"=>"H",
          "answer_C"=>"Hy",
          "answer_D"=>"Hn",
          "correct_answer"=>"H"
        }
      }
    assert_response :success
    assert_select "title", "Quiz#{@base_title}"
    assert_select "h1", "Chemical Symbol Quiz"
    assert_select "p", "1. What is the chemical symbol for Hydrogen?"
    assert_match /H\s*✔️/, response.body
    assert_match /C\s*❌/, response.body
    assert_select "input[type=?]", 'radio', count: 4
    assert_select "input[type=?]", 'submit', count: 1
    assert_select "input[value=?]", '0', count: 1
    #assert_select "input checked", count: 1
  end

  test "should post correct answer to question" do
    post quiz_path,
      params: {
        "answer"=>"Tb",
        "quiz" => {
          "question_number"=>"2",
          "page"=>"question",
          "score"=>"3",
          "question"=>"What is the chemical symbol for Terbium?",
          "answer_A"=>"T",
          "answer_B"=>"U",
          "answer_C"=>"Tb",
          "answer_D"=>"Ti",
          "correct_answer"=>"Tb"
        }
      }
    assert_response :success
    assert_match /Tb\s*✔️/, response.body
    assert_no_match '❌', response.body
    assert_select "input[value=?]", '2', count: 1
    assert_select "input[value=?]", '4', count: 1
  end
  
  test "should show correct answer if no answer chosen" do
    post quiz_path,
    params: {
        "quiz" => {
          "question_number"=>"1",
          "page"=>"question",
          "score"=>"0",
          "question"=>"What is the chemical symbol for Hydrogen?",
          "answer_A"=>"C",
          "answer_B"=>"H",
          "answer_C"=>"Hy",
          "answer_D"=>"Hn",
          "correct_answer"=>"H"
        }
      }
    assert_response :success
    assert_match /H\s*✔️/, response.body
    assert_no_match '❌', response.body
    assert_select "input[value=?]", '1', count: 1
    assert_select "input[value=?]", '0', count: 1
  end
  
  test "should show next question after answer page" do
    post quiz_path,
      params: { quiz: {"question_number"=>"3", "page"=>"answer", "score"=>"2"} }
      assert_response :success
      assert_match 'Question 4', response.body
      assert_select "input[type=?]", 'radio', count: 4
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
  
end
