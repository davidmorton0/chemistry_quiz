require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
=begin
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
=end
end
