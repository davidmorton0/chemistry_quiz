require 'test_helper'

class HighScoresTest < ActionDispatch::IntegrationTest
  def setup
    #get new quiz
    @user = users(:michael)
    log_in_as(@user)
    @quiz_type = quiz_types(:two)
    get quiz_type_path(@quiz_type.id)
    follow_redirect!
    @quiz = @user.quiz
    @score = scores(:one)
  end
  
  test "should show high score for quiz" do
    get user_path(@user)
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{@score.score} / #{@quiz_type.num_questions}"
        assert_select 'td:nth-child(5)', "16m 40s"
      end  
    end
  end
  
  test "should update high score for quiz" do
    answer_all_questions_correctly(@quiz)
    
    #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: #{num_questions}/#{num_questions}", response.body
    assert_not flash.empty?
    
    #check high score updated
    get user_path(@user)
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
    Score.find(@score.id).destroy
    answer_all_questions_correctly(@quiz)
                            
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
    Score.find(@user.scores.first.id).destroy
    @score.save
  end
  
  test "should create high score if none and score = 0 without flash" do
    Score.find(@score.id).destroy
    answer_all_questions_incorrectly(@quiz)
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
    Score.find(@user.scores.first.id).destroy
    @score.save
  end

  test "should update fastest time if score is 10/10 and faster than previous" do
    @quiz_type = quiz_types(:three)
    get quiz_type_path(@quiz_type.id)
    follow_redirect!
    @quiz = @user.quiz
    @score = scores(:two)
    @quiz.update(created_at: 1.hour.ago)
    
    answer_all_questions_correctly(@quiz)
    
    #check response on page
    get quiz_path
    assert_not flash.empty?
    assert_changes '@score.fastest_time' do
      @score.reload
    end
  end
  
  test "should create fastest time if score is 10/10 and none exists" do
    @quiz_type = quiz_types(:three)
    get quiz_type_path(@quiz_type.id)
    follow_redirect!
    @quiz = @user.quiz
    @score = scores(:two)
    @score.update(fastest_time: nil, score: @quiz_type.num_questions - 1)
    @quiz.update(created_at: 1.hour.ago)
    @score.reload
    assert_nil @score.fastest_time
    answer_all_questions_correctly(@quiz)
    
    #check response on page
    get quiz_path
    assert_not flash.empty?
    @score.reload
    assert_not_nil @score.fastest_time
  end
  
  test "should not update fastest time if score is 10/10 and slower than previous" do
    @quiz_type = quiz_types(:three)
    get quiz_type_path(@quiz_type.id)
    follow_redirect!
    @quiz = @user.quiz
    @score = scores(:two)
    @quiz.update(created_at: 5.hours.ago)
    
    answer_all_questions_correctly(@quiz)
    
    #check response on page
    get quiz_path
    assert flash.empty?
    assert_no_difference '@score.fastest_time' do
      @score.reload
    end
  end
  
  test "should not update fastest time if score is not 10/10" do
    @quiz_type = quiz_types(:three)
    get quiz_type_path(@quiz_type.id)
    follow_redirect!
    @quiz = @user.quiz
    @score = scores(:two)
    
    answer_all_questions_incorrectly(@quiz)
    
    #check response on page
    get quiz_path
    assert flash.empty?
    assert_no_difference '@score.fastest_time' do
      @score.reload
    end
  end
end
