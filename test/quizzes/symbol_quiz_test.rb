require 'test_helper'

class SymbolQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz_type = create(:new_quiz_type)
    @symbol_quiz = SymbolQuiz.new(
                    level: @quiz_type.level,
                    num_questions: @quiz_type.num_questions)
  end
  
  test "should make symbol questions" do
    @quiz = create(:new_quiz)
    question_maker = QuestionMaker.new(quiz: @quiz)
    @symbol_quiz.make_questions(question_maker)
    assert_equal @quiz.questions.count, @quiz_type.num_questions
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
    question_index = @symbol_quiz.question_index
    assert_equal question_index.count, question_index.uniq.count
    assert_operator question_index.count, :>=, 10
  end

end
