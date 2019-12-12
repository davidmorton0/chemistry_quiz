require 'test_helper'

class HighScoresTest < ActionDispatch::IntegrationTest
  def setup
    #get new quiz
    @quiz = create(:new_quiz)
    @user = @quiz.user
    @quiz_type = @quiz.quiz_type
    log_in_as(@user)
  end
=begin
  test "should show high score for quiz" do
    @fastscore = create(:fastscore)
    get user_path(@user)
    assert_select 'title', "#{@user.name}#{base_title}"
    assert_select 'table' do
      assert_select 'tr:nth-child(2)' do
        assert_select 'td:nth-child(1)', "#{@quiz_type.name}"
        assert_select 'td:nth-child(2)', "#{@quiz_type.level}"
        assert_select 'td:nth-child(3)', "#{@quiz_type.difficulty}"
        assert_select 'td:nth-child(4)', "#{@fastscore.score} / #{@quiz_type.num_questions}"
        assert_select 'td:nth-child(5)', "50s"
      end  
    end
  end
  
  test "should update high score for quiz" do
    @score5 = create(:score5)
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
    @score5 = create(:score5)
    answer_all_questions_incorrectly(@quiz)
    
    #check response on page
    get quiz_path
    assert_match "You scored: 0/#{@quiz_type.num_questions}", response.body
    assert flash.empty?
    assert_no_difference '@score5.score' do
      @score5.reload
    end
  end
  
  test "should create high score if none" do
    answer_all_questions_correctly(@quiz)

    #check response on page
    get quiz_path
    num_questions = @quiz_type.num_questions
    assert_match "You scored: #{num_questions}/#{num_questions}", response.body
    assert_match "New High Score!", flash[:info]
    
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
  end
  
  test "should create high score if none and score = 0 without flash" do
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
  end
=end
end
