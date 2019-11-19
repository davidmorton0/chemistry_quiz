require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get current quiz start page" do
    @user = users(:michael)
    log_in_as(@user)
    assert_no_difference 'Quiz.count' do
      get quizzes_path
      assert_redirected_to quiz_path(Quiz.find_by(user_id: @user.id).id)
      follow_redirect!
      assert_template "show"
      assert_select "h1", @user.quiz.quiz_type.name
      assert_select "input[type=?]", 'radio', count: @user.quiz.answers.count
      assert_select "p", "1. #{@user.quiz.questions.first.prompt}"
      assert_select "button[type=?]", 'submit', count: @user.quiz.questions.count + 1
    end
  end

  test "should start new quiz" do
    @user = users(:michael)
    log_in_as(@user)
    @quiz_type = quiz_types(:one)
    assert_no_difference 'Quiz.count' do
      get quiz_type_path(@quiz_type.id)
      assert_redirected_to quiz_path(Quiz.find_by(user_id: @user.id).id)
      follow_redirect!
      assert_template "show"
      assert_select "h1", @user.quiz.quiz_type.name
      assert_select "input[type=?]", 'radio', count: @user.quiz.answers.count
      assert_select "p", "1. #{@user.quiz.questions.first.prompt}"
      assert_select "button[type=?]", 'submit', count: @user.quiz.questions.count + 1
    end
  end

  test "should redirect from resume quiz to new quiz page for new user" do
    @user = users(:mary)
    log_in_as(@user)
    get quizzes_path
    assert_redirected_to quiz_types_path
  end

  test "should answer a question incorrectly" do
    
    question = questions(:one)
    patch quiz_path(question.quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>question.id,
                              "quiz"=>{question.id.to_s=>"J"},
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>question.quiz.id}, xhr: true
    question.reload
    assert_equal question.answered, true
    assert_equal question.chosen_answer, "J"
    assert_equal quizzes(:one).score, 1
    assert_response :success
  end
  
  test "should answer a question correctly" do
    
    question = questions(:four)
    patch quiz_path(question.quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>question.id,
                              "quiz"=>{question.id.to_s=>"H"},
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>question.quiz.id}, xhr: true
    question.reload
    assert_equal question.answered, true
    assert_equal question.chosen_answer, "H"
    assert_equal quizzes(:one).score, 2
    assert_response :success
  end
end
