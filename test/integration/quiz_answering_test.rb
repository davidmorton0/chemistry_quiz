require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:mark)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    post quizzes_path
    assert_redirected_to quiz_path
    follow_redirect!
    get quiz_path
  end

  test "should show quiz start page" do
    setup
    assert_select "h1", "Chemical Symbol Quiz"
    assert_no_match '✔️', response.body
    assert_no_match '❌', response.body
  end
  
  test "should answer question correctly" do
    setup
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.first
    patch question_path(@question.id), params: { "id"=>@question.id,
                    "answer"=>@question.correct_answer,
                    "commit"=>"Answer",
                    "controller" => "questions",
                    "action" => "update"
                    }, xhr: true
    assert_equal "location.reload();", response.body
    get quiz_path
    assert_select "div[class=radio]", /✔️/, count: 1
    assert_no_match '❌', response.body
  end
  
  test "should answer question incorrectly" do
    setup
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.second
    @answer = @question.answers.first.text == @question.correct_answer ? @question.answers.second.text : @question.answers.first.text
    patch question_path(@question.id), params: { "id"=>@question.id,
                    "answer"=>@answer,
                    "commit"=>"Answer",
                    "controller" => "questions",
                    "action" => "update"
                    }, xhr: true
    assert_equal "location.reload();", response.body
    get quiz_path
    assert_select "div[class=radio]", /✔️/, count: 1
    assert_select "div[class=radio]", /❌/, count: 1
  end
  
  test "should show answer when no answer given" do
    setup
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.third
    patch question_path(@question.id), params: { "id"=>@question.id,
                    "commit"=>"Answer",
                    "controller" => "questions",
                    "action" => "update"
                    }, xhr: true
    assert_equal "location.reload();", response.body
    get quiz_path
    assert_select "div[class=radio]", /✔️/, count: 1
    assert_select "div[class=radio]", {count: 0, text:/❌/}
  end
  
  test "should show results at end of test" do
    setup
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @quiz.questions.each do |question|
      patch question_path(question.id), params: { "id"=>question.id,
                      "commit"=>"Answer",
                      "controller" => "questions",
                      "action" => "update"
                      }, xhr: true
      get quiz_path
    end
    assert_select "div[class=radio]", /✔️/, count: 10
    assert_match "You scored: #{@quiz.score}/#{@quiz.questions.count}", response.body
  end
end
