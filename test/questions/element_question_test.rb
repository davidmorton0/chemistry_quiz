require 'test_helper'

class ElementQuestionTest < ActionDispatch::IntegrationTest

  test "should make element question" do
    question = ElementQuestion.new.element_question(1)
    assert_equal "What is the element with the symbol He?", question[:prompt]
    assert_equal "Helium", question[:correct_answer]
    assert_equal question[:answers].count, 4
  end
  
  test "should make element question answers" do
    question = ElementQuestion.new.element_question(1)
    assert_equal question[:answers].count, 4
    assert_equal question[:answers].select{ |answer| answer == "Helium" }.count, 1
    assert_equal question[:answers].select{ |answer| answer != "Helium" }.count, 3
    question[:answers].each do |answer|
        assert_match (/[A-Z][a-z]+/), answer
      end
  end
end
