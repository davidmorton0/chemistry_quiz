class QuizzesHelperTest < ActionView::TestCase

  test "should generate tick or cross for question" do
    question = Question.new(
      chosen_answer: "Answer",
      correct_answer: "Answer")
    answer = Answer.new(text: "Answer")
    assert_equal check(question, answer), "\u{2714}"
    
    question.correct_answer = "Not Answer"
    assert_equal check(question, answer), "\u{274C}"
    
    question.chosen_answer = "Something else"
    assert_equal check(question, answer), ""
  end
  
  test "should show answered questions" do
    question = Question.new(
      chosen_answer: "Answer",
      correct_answer: "Answer",
      answered: true)
    answer = Answer.new(text: "Answer")
    assert_equal show_answered(question, answer), "correct"
    
    answer = Answer.new(text: "Not Answer")
    assert_equal show_answered(question, answer), "incorrect"
    
    question.answered = false
    assert_equal show_answered(question, answer), "unanswered"
  end
  
  test "should show format formulas to subscript" do
    assert_equal format_formula("N2H4"), "N<sub>2</sub>H<sub>4</sub>"
  end
end