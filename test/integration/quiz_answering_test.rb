require 'test_helper'

class QuizAnsweringTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:mark)
    @quiz_type = quiz_types(:one)
    log_in_as(@user)
    assert is_logged_in?
    get quiz_type_path(@quiz_type.id)
    assert_redirected_to quiz_path
    follow_redirect!
  end

  test "should show blank quiz start page" do
    @quiz = Quiz.find_by user_id: @user.id
    assert_select "h1", @quiz.quiz_type.name
    assert_no_match '\u{2714}️', response.body
    assert_no_match '\u{274C}️', response.body
    assert_select "div.radio#correct", 0
    assert_select "div.radio#incorrect", @quiz.answers.count
  end

  test "should answer a question correctly" do
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.first
    patch quiz_path, params: {
                              "_method"=>"patch",
                              "submit"=>@question.id.to_s,
                              "quiz"=>{@question.id.to_s=>@question.correct_answer.to_s},
                              "commit"=>"Answer",
                              "controller"=>"quizzes",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
    get quiz_path
    assert_select "div.radio#correct", /\u{2714}/, count: 1
    assert_no_match '\u{274C}', response.body
    assert_difference '@quiz.score' do
      @quiz.reload
    end
    @question.reload
    assert_equal @question.answered, true
    assert_equal @question.chosen_answer, @question.correct_answer
  end
  
  test "should answer a question incorrectly" do
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.second
    @answer = @question.answers.first.text == @question.correct_answer ? @question.answers.second.text : @question.answers.first.text
    patch quiz_path, params: {
                              "_method"=>"patch",
                              "submit"=>@question.id.to_s,
                              "quiz"=>{@question.id.to_s=>@answer},
                              "commit"=>"Answer",
                              "controller"=>"quizzes",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
    get quiz_path
    assert_select "div.radio#correct", count: 1
    assert_no_match /\u{2714}/, response.body
    #assert_select "div.radio#incorrect", '\u{274C}' count: 1
    assert_no_difference '@quiz.score' do
      @quiz.reload
    end
    @question.reload
    assert_equal @question.answered, true
    assert_not_equal @question.chosen_answer, @question.correct_answer
  end
  
  test "should answer question when no answer selected" do
    @quiz = Quiz.find_by user_id: @user.id
    @question = @quiz.questions.third
    patch quiz_path, params: {
                              "_method"=>"patch",
                              "submit"=>@question.id,
                              "commit"=>"Answer",
                              "controller"=>"quizzes",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
    get quiz_path
    assert_select "div.radio#correct", 1
    assert_select "div.radio#incorrect", @quiz.answers.count - 1
    assert_no_match /[\u{2714}]️/, response.body
    assert_no_match /[\u{274C}]/, response.body
    assert_no_difference '@quiz.score' do
      @quiz.reload
    end
    @question.reload
    assert_equal @question.answered, true
    assert_nil @question.chosen_answer
  end
  
  test "should show results at end of test" do
    @quiz = Quiz.find_by user_id: @user.id
    @quiz.questions.each do |question|
      patch quiz_path, params: {
                              "_method"=>"patch",
                              "submit"=>question.id,
                              "quiz"=>{question.id.to_s=>question.correct_answer.to_s},
                              "commit"=>"Answer",
                              "controller"=>"quizzes",
                              "action"=>"update",
                              "id"=>@quiz.id}, xhr: true
      get quiz_path
    end
    assert_select "div.radio#correct", @quiz.questions.count
    assert_select "div.radio#incorrect", @quiz.answers.count - @quiz.questions.count
    ticks = response.body.scan(/\u{2714}/).count
    crosses = response.body.scan(/\u{274C}/).count
    @quiz.reload
    assert_equal @quiz.score, ticks
    assert_equal @quiz.questions.count - @quiz.score, crosses
    assert_match "You scored: #{@quiz.score}/#{@quiz.questions.count}", response.body
  end
  
  test "should answer all unanswered questions" do
    @quiz = @user.quiz
    patch quiz_path, params: {
                              "_method"=>"patch",
                              "submit"=>"all",
                              "quiz"=>{
                                @quiz.questions.first.id.to_s => @quiz.questions.first.correct_answer,
                                @quiz.questions.second.id.to_s => @quiz.questions.second.correct_answer,
                              },
                              "commit"=>"Answer All",
                              "controller"=>"quizzes",
                              "action"=>"update",
                              "id"=>@quiz.id }, xhr: true
    get quiz_path
    @quiz.reload
    assert_select "div.radio#correct", @quiz.questions.count
    assert_match "You scored: #{@quiz.score}/#{@quiz.questions.count}", response.body
  end
end
