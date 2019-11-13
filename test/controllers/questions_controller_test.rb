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
  
  test "should answer a question incorrectly" do
    
    question = questions(:one)
    patch question_path(question.id), params: {
                              "_method"=>"patch",
                              "quiz"=>{question.id.to_s=>"J"},
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>question.id.to_s}, xhr: true
    question.reload
    assert_equal question.answered, true
    assert_equal question.chosen_answer, "J"
    assert_equal quizzes(:one).score, 1
    assert_response :success
  end
  
  test "should answer a question correctly" do
    
    question = questions(:four)
    patch question_path(question.id), params: {
                              "_method"=>"patch",
                              "quiz"=>{question.id.to_s=>"H"},
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>question.id.to_s}, xhr: true
    question.reload
    assert_equal question.answered, true
    assert_equal question.chosen_answer, "H"
    assert_equal quizzes(:one).score, 2
    assert_response :success
  end

end
