require 'test_helper'

class QuizAnsweringTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:mark)
    log_in_as(@user)
    assert is_logged_in?
    post quizzes_path
    assert_redirected_to quiz_path(Quiz.find_by(user_id: @user.id).id)
    follow_redirect!
    get quiz_path
  end

  test "should show blank quiz start page" do
    assert_select "h1", "Chemical Symbol Quiz"
    assert_no_match '✔️', response.body
    assert_no_match '❌', response.body
  end
  
  test "should answer question correctly" do
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.first
    patch quiz_path(@quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>@question.id,
                              "quiz"=>{@question.id.to_s=>@question.correct_answer},
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
    assert_equal "location.reload();", response.body
    get quizzes_path
    follow_redirect!
    assert_select "div[class=radio]", /✔️/, count: 1
    assert_no_match '❌', response.body
    assert_difference '@quiz.score' do
      @quiz.reload
    end
  end
  
  test "should answer question incorrectly" do
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.second
    @answer = @question.answers.first.text == @question.correct_answer ? @question.answers.second.text : @question.answers.first.text
    patch quiz_path(@quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>@question.id,
                              "quiz"=>{@question.id.to_s=>@answer},
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
    assert_equal "location.reload();", response.body
    get quizzes_path
    follow_redirect!
    assert_select "div[class=radio]", /✔️/, count: 1
    assert_select "div[class=radio]", /❌/, count: 1
    assert_no_difference '@quiz.score' do
      @quiz.reload
    end
  end
  
  test "should show answer when no answer given" do
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.third
    patch quiz_path(@quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>@question.id,
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
    assert_equal "location.reload();", response.body
    get quizzes_path
    follow_redirect!
    assert_select "div[class=radio]", /✔️/, count: 1
    assert_select "div[class=radio]", {count: 0, text:/❌/}
    assert_no_difference '@quiz.score' do
      @quiz.reload
    end
  end
  
  test "should show results at end of test" do
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    @quiz.questions.each do |question|
      patch quiz_path(@quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>question.id,
                              "commit"=>"Answer",
                              "controller"=>"questions",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
      get quizzes_path
      follow_redirect!
    end
    assert_select "div[class=radio]", /✔️/, count: 10
    assert_match "You scored: #{@quiz.score}/#{@quiz.questions.count}", response.body
  end
  
  test "should answer all unanswered questions" do
    assert_select "h1", "Chemical Symbol Quiz"
    @quiz = Quiz.find_by user_id: @user.id
    patch quiz_path(@quiz.id), params: {
                              "_method"=>"patch",
                              "submit"=>"all",
                              "quiz"=>{
                                @quiz.questions.first.id.to_s => @quiz.questions.first.answers.first.text,
                                @quiz.questions.second.id.to_s => @quiz.questions.second.answers.first.text,
                                @quiz.questions.third.id.to_s => @quiz.questions.third.answers.first.text
                              },
                              "commit"=>"Answer All",
                              "action"=>"update",
                              "id"=>@quiz.id }, xhr: true
    get quizzes_path
    follow_redirect!
    @quiz.reload
    assert_select "div[class=radio]", /✔️/, count: 10
    assert_match "You scored: #{@quiz.score}/#{@quiz.questions.count}", response.body
  end
end
