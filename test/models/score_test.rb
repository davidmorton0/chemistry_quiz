require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def setup
    @score = create(:new_score)
  end
  
  test "should be valid" do
    assert @score.valid?
  end
  
  test "should have number of score >= 0" do
    @score.score = nil
    assert_not @score.valid?
    @score.score = -1
    assert_not @score.valid?
  end
  
  test "should have user" do
    @score.user_id = nil
    assert_not @score.valid?
  end
  
  test "should have a quiz_type" do
    @score.quiz_type_id = nil
    assert_not @score.valid?
  end
end
