require 'test_helper'

class GlobalHighScoresTest < ActionDispatch::IntegrationTest

  test "should get global high score page" do
    get scores_path
    assert_response :success
    assert_select "title", "High Scores#{base_title}"
    assert_template 'scores/index'
    assert_select 'div.pagination', count: 2
    assert_select 'a[href=?]', '/scores?page=1', count: 2
    assert_select 'a[href=?]', '/scores?page=2', count: 4
    first_page_of_scores = QuizType.paginate(page: 1, per_page: 5)
    first_page_of_scores.each do |quiz_type|
      assert_select 'a[href=?]', quiz_type_path(quiz_type), text: quiz_type.name
      assert_select 'td', quiz_type.level.to_s
      assert_select 'td', quiz_type.difficulty.to_s
      @score = Score.where(quiz_type_id: quiz_type.id).order(score: :desc, fastest_time: :asc).first
      assert_select 'td', "#{@score.score} / #{quiz_type.num_questions}"
      assert_select 'td', @score.user.name
    end
  end
end
