require 'test_helper'

class HighScoresTest < ActionDispatch::IntegrationTest
  def setup
    @score = create(:new_score, :score_10_1_min)
    @user = @score.user
    @quiz_type = @score.quiz_type
    log_in_as(@user)
  end

  test "should show high score for quiz" do
    get profile_path
    assert_response :success
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{@score.score} / #{@quiz_type.num_questions}"
        assert_select 'td:nth-child(5)', "1m 0s"
      end  
    end
  end
  
  test "should update high score for quiz" do
    @quiz = create(:quiz_10_questions, :unanswered, :with_score_5)
    @user = @quiz.user
    @quiz_type = @quiz.quiz_type
    log_in_as(@user)
    answer_all_questions_correctly(@quiz)
    
    #check response on page
    get quiz_path
    assert_response :success
    num_questions = @quiz_type.num_questions
    assert_match "You scored: #{num_questions}/#{num_questions}", response.body
    assert_not flash.empty?
    
    #check high score updated
    get profile_path
    assert_response :success
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{num_questions} / #{num_questions}"
      end  
    end
  end
  
  test "should not update high score for quiz if not high score" do
    @quiz = create(:quiz_10_questions, :unanswered, :with_score_5)
    @user = @quiz.user
    @quiz_type = @quiz.quiz_type
    @score = Score.find_by(user_id: @user.id, quiz_type: @quiz_type)
    log_in_as(@user)

    answer_all_questions_incorrectly(@quiz)
    
    #check response on page
    get quiz_path
    assert_match "You scored: 0/#{@quiz_type.num_questions}", response.body
    assert flash.empty?
    assert_no_difference '@score.score' do
      @score.reload
    end
  end
  

  test "should create high score if none" do
    @quiz = create(:quiz_10_questions, :unanswered)
    @user = @quiz.user
    @quiz_type = @quiz.quiz_type
    log_in_as(@user)
    
    #check no high score
    get profile_path
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_no_match "#{@quiz_type.name}", response.body
    
    answer_all_questions_correctly(@quiz)

    #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: #{num_questions}/#{num_questions}", response.body
    assert_match "New High Score!", flash[:info]
    
    #check high score created
    get profile_path
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{num_questions} / #{num_questions}"
      end  
    end
  end

  test "should create high score if none and score = 0 without flash" do
    @quiz = create(:quiz_10_questions, :unanswered)
    @user = @quiz.user
    @quiz_type = @quiz.quiz_type
    log_in_as(@user)
    
    answer_all_questions_incorrectly(@quiz)
    
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: 0/#{num_questions}", response.body
    assert flash.empty?
    
    #check high score created
    get profile_path
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "0 / #{num_questions}"
      end  
    end
  end

end
