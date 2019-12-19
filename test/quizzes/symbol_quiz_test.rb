require 'test_helper'

class SymbolQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz = create(:new_quiz)
    @symbol_quiz = SymbolQuiz.new(@quiz)
  end
  
  test "should make symbol quiz" do
    assert @symbol_quiz.quiz === @quiz
    @symbol_quiz.make_quiz((0..9).to_a)
    assert_equal @quiz.questions.count, @quiz.quiz_type.num_questions
    @quiz.questions.each do |question|
      assert_equal question.quiz_id, @quiz.id
      assert_equal question.answered, false
      assert_match (/What is the chemical symbol for [A-Z][a-z]*[?]/), question.prompt
      assert_equal question.answers.count, 4
      assert_equal question.answers.map { |answer| answer.text }.uniq.length, 4
      assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
      question.answers.each do |answer|
        assert_match (/[A-Z][a-z]?/), answer.text
        assert_equal answer.question_id, question.id
      end
    end
  end
  
  test "should get question_index" do
    (1..3).each do |n|
      question_index = @symbol_quiz.question_index(n)
      assert_equal question_index.count, question_index.uniq.count
      assert_operator question_index.count, :>=, 10
    end
  end
  
  test "should make symbol question" do
    question = SymbolQuiz.new(@quiz).symbol_question(1)
    assert_equal "What is the chemical symbol for Helium?", question[:prompt]
    assert_equal "He", question[:correct_answer]
    assert_equal question[:answers].count, 4
  end
  
  test "should make symbol question answers" do
    answers = SymbolQuiz.new(@quiz).make_answers("Helium", "He")
    assert_equal answers.count, 4
    assert_equal answers.select{ |answer| answer == "He" }.count, 1
    assert_equal answers.select{ |answer| answer != "He" }.count, 3
    answers.each do |answer|
        assert_match (/[A-Z][a-z]?/), answer
      end
  end
end
