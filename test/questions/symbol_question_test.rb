require 'test_helper'

class SymbolQuizTest < ActionDispatch::IntegrationTest

  test "should make symbol question" do
    question = SymbolQuestion.new.symbol_question(1)
    assert_equal "What is the chemical symbol for Helium?", question[:prompt]
    assert_equal "He", question[:correct_answer]
    assert_equal question[:answers].count, 4
  end
  
  test "should make symbol question answers" do
    answers = SymbolQuestion.new.make_answers("Helium", "He")
    assert_equal answers.count, 4
    assert_equal answers.select{ |answer| answer == "He" }.count, 1
    assert_equal answers.select{ |answer| answer != "He" }.count, 3
    answers.each do |answer|
        assert_match (/[A-Z][a-z]?/), answer
      end
  end
end
