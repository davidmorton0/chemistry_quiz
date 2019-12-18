require 'test_helper'

class QuizzesInfoTest < ActionView::TestCase
  include QuizzesHelper
  
  test "should show quiz info and quiz button" do
    @quiz = create(:quiz_10_questions, :with_score_5)
    render partial: 'quizzes/info', locals: { quiz: @quiz }
    assert_select "div.col-sm-4#score" do
      assert_select 'p.score', score(@quiz)
      assert_select 'p.info', "Your High Score: #{show_high_score(@quiz)}"
      assert_select "p.info.l#{@quiz.quiz_type.level}", "Level: #{@quiz.quiz_type.level}"
    end
    assert_select "div.col-sm-4#quizname" do
      assert_select 'h1', @quiz.quiz_type.name
    end
    assert_select "div.col-sm-4#startagain" do
      assert_select 'a.btn.btn-lg.btn-primary.quiz[href=?]', quiz_type_path(@quiz.quiz_type), 'Start again'
      assert_select 'a.btn.btn-lg.btn-primary.quiz[href=?]', quiz_types_path, 'Choose a new quiz'
    end
  end
  
  test "should quiz button" do
    @quiz = create(:quiz_10_questions, :with_score_5)
    render partial: 'quizzes/info', locals: { quiz: @quiz }
    assert_select "div.col-sm-4#startagain" do
      assert_select "a.btn.btn-lg.btn-primary.level", "Level #{@quiz.quiz_type.level}", count: 1
    end
  end
end
