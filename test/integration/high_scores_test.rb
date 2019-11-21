require 'test_helper'

class HighScoresTest < ActionDispatch::IntegrationTest
  
  test "should show high score for quiz" do
    @score = scores(:two)
    @user = @score.user
    @quiz_type = @score.quiz_type
    log_in_as(@user)
    get user_path(@user)
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{@score.score} / #{@quiz_type.num_questions}"
      end  
    end
  end
  
  test "should update high score for quiz" do
      #get new quiz
    @user = users(:michael)
    @quiz_type = quiz_types(:one)
    assert_not_nil Score.find_by(user_id: @user.id, quiz_type_id: @quiz_type.id)
    log_in_as(@user)
    assert is_logged_in?
    get quiz_type_path(@quiz_type.id)
    assert_redirected_to quiz_path
    follow_redirect!
    @quiz = @user.quiz
      #answer all questions correctly
    answers = {}
    @quiz.questions.map{ |question| 
      answers[question.id.to_s] = question.correct_answer
    }
    patch quiz_path, params: {
                            "_method"=>"patch",
                            "submit"=>"all",
                            "quiz"=>answers,
                            "commit"=>"Answer All",
                            "controller"=>"quizzes",
                            "action"=>"update",
                            "id"=>@quiz.id}, xhr: true
      #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: #{num_questions}/#{num_questions}", response.body
    assert_not flash.empty?
    
      #check high score updated
    get user_path(@user)
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(3)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{num_questions} / #{num_questions}"
      end  
    end
  end
  
  test "should not update high score for quiz if not high score" do
      #get new quiz
    @user = users(:michael)
    @quiz_type = quiz_types(:one)
    @score = Score.find_by(user_id: @user.id, quiz_type_id: @quiz_type.id)
    assert_not_nil @score
    log_in_as(@user)
    assert is_logged_in?
    get quiz_type_path(@quiz_type.id)
    assert_redirected_to quiz_path
    follow_redirect!
    @quiz = @user.quiz
      #answer all questions incorrectly
    patch quiz_path, params: {
                            "_method"=>"patch",
                            "submit"=>"all",
                            "commit"=>"Answer All",
                            "controller"=>"quizzes",
                            "action"=>"update",
                            "id"=>@quiz.id}, xhr: true
      #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: 0/#{num_questions}", response.body
    assert flash.empty?
    assert_no_difference '@score.score' do
      @score.reload
    end
  end
  
  test "should create high score if none" do
      #get new quiz
    @user = users(:mark)
    assert_nil Score.find_by(user_id: @user.id)
    @quiz_type = quiz_types(:one)
    log_in_as(@user)
    assert is_logged_in?
    get quiz_type_path(@quiz_type.id)
    assert_redirected_to quiz_path
    follow_redirect!
    @quiz = @user.quiz
    
      #answer all questions correctly
    answers = {}
    @quiz.questions.map{ |question| 
      answers[question.id.to_s] = question.correct_answer
    }
    patch quiz_path, params: {
                            "_method"=>"patch",
                            "submit"=>"all",
                            "quiz"=>answers,
                            "commit"=>"Answer All",
                            "controller"=>"quizzes",
                            "action"=>"update",
                            "id"=>@quiz.id}, xhr: true
                            
      #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: #{num_questions}/#{num_questions}", response.body
    assert_not flash.empty?
    
      #check high score updated
    get user_path(@user)
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{num_questions} / #{num_questions}"
      end  
    end
    Score.find_by(user_id: @user.id).destroy
  end
  
  test "should create high score if none and score = 0 without flash" do
    #get new quiz
    @user = users(:mark)
    assert_nil Score.find_by(user_id: @user.id)
    @quiz_type = quiz_types(:one)
    log_in_as(@user)
    assert is_logged_in?
    get quiz_type_path(@quiz_type.id)
    assert_redirected_to quiz_path
    follow_redirect!
    @quiz = @user.quiz
      #answer all questions incorrectly
    patch quiz_path, params: {
                            "_method"=>"patch",
                            "submit"=>"all",
                            "commit"=>"Answer All",
                            "controller"=>"quizzes",
                            "action"=>"update",
                            "id"=>@quiz.id}, xhr: true
      #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: 0/#{num_questions}", response.body
    assert flash.empty?
    
      #check high score updated
    get user_path(@user)
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "0 / #{num_questions}"
      end  
    end
    Score.find_by(user_id: @user.id).destroy
  end
end
