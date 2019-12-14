require 'test_helper'

class QuizzesHelperTest < ActionView::TestCase

  test "should generate tick for correctly answered question" do
    @answer = create(:new_answer)
    @answer.question.update( answered: true,
                      chosen_answer: @answer.text,
                      correct_answer: @answer.text )
    assert_equal check(@answer), "\u{2714}"
  end
  
  test "should generate cross for incorrectly answered question" do
    @answer = create(:new_answer)
    @answer.question.update( answered: true,
                      chosen_answer: @answer.text,
                      correct_answer: "Not Answer" )
    assert_equal check(@answer), "\u{274C}"
  end
  
  test "should not return tick or cross if this answer not chosen" do
    @answer = create(:new_answer)
    @answer.question.update(answered: true,
                            chosen_answer: "Something Else",
                            correct_answer: @answer.text )
    assert_equal check(@answer), ""
  end

  test "should show correct answered answer" do
    @answer = build(:answer_with_question, :correct)
    @answer.question.answered = true
    assert_equal show_answered(@answer), "correct"
  end
  
  test "should show incorrect answered answer" do
    @answer = build(:answer_with_question, :incorrect)
    @answer.question.answered = true
    assert_equal show_answered(@answer), "incorrect"
  end
  
  test "should show unanswered answer" do
    @answer = build(:answer_with_question, :incorrect)
    assert_equal show_answered(@answer), "unanswered"
  end
  
  test "should be checked if answer is chosen_answer" do
    @answer = build(:answer_with_question, :correct)
    @answer.question.chosen_answer = @answer.text
    assert checked?(@answer)
  end
  
  test "should not be checked if answer isn't chosen_answer" do
    @answer = build(:answer_with_question, :correct)
    @answer.question.chosen_answer = "No"
    assert_not checked?(@answer)
  end
  
  test "should format formulas to subscript" do
    assert_equal format_formula("N2H4"), "N<sub>2</sub>H<sub>4</sub>"
  end
  
  test "should format formula with no numbers" do
    assert_equal format_formula("Mg"), "Mg"
  end
  
  test "should format formula with blank input" do
    assert_equal format_formula(""), ""
  end
  
  test "should return high score for quiz" do
    @quiz = create(:quiz_10_questions, :unanswered, :with_score_5)
    assert_equal show_high_score(@quiz), 5
  end
  
  test "should return nothing if no high score for quiz" do
    @quiz = create(:quiz_10_questions, :unanswered)
    assert_equal show_high_score(@quiz), ""
  end
  
  test "should format answer formula for formula question prompt" do
    @answer = build(:answer_with_question)
    @answer.text = "H2O"
    @answer.question.prompt = "What is the chemical formula for Water?"
    assert_equal label_text(@answer), "H<sub>2</sub>O"
  end
  
  test "should format answer formula for non formula question prompt" do
    @answer = build(:answer_with_question)
    @answer.text = "H2O"
    @answer.question.prompt = "What?"
    assert_equal label_text(@answer), "H2O"
  end
  
  test "should format question formula for name question prompt" do
    @question = build(:new_question)
    @question.prompt = "What is the name of the substance with the formula A5B12?"
    assert_equal question_text(@question), "What is the name of the substance with the formula A<sub>5</sub>B<sub>12</sub>?"
  end
  
  test "should not format question formula for non-name question prompt" do
    @question = build(:new_question)
    @question.prompt = "What formula A5B12?"
    assert_equal question_text(@question), @question.prompt
  end
  
  test "should return quiz types with same name and not others" do
    quiz1 = create(:new_quiz)
    quiz2 = create(:new_quiz)
    quiz3 = create(:new_quiz)
    quiz1.quiz_type.update(name: "A Quiz")
    quiz2.quiz_type.update(name: "A Quiz")
    quiz3.quiz_type.update(name: "Another Quiz")
    quizzes = similar_quizzes(quiz1)
    assert_equal quizzes.count, 2
    assert quizzes.include?(quiz1.quiz_type)
    assert quizzes.include?(quiz2.quiz_type)
    assert_not quizzes.include?(quiz3.quiz_type)
  end
  
  test "should return score message if quiz answered" do
    @quiz = create(:quiz_10_questions, :correct)
    @quiz.quiz_type.num_questions = 7
    @quiz.score = 4
    assert_equal score(@quiz), "You scored: 4/7"
  end
  
  test "should return score if quiz not finished" do
    @quiz = create(:quiz_10_questions, :unanswered)
    assert_equal score(@quiz), "Current Score: 0"
  end
end