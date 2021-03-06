require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @answer = create(:new_answer)
  end
  
  test "should be valid" do
    assert @answer.valid?
  end
  
  test "should have text" do
    @answer.text = ""
    assert_not @answer.valid?
  end
  
  test "should belong to question" do
    @answer.question = nil
    assert_not @answer.valid?
  end

end
