require 'test_helper'

class ElementQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz_type = create(:new_quiz_type)
    @element_quiz = ElementQuiz.new(
                    level: @quiz_type.level,
                    num_questions: @quiz_type.num_questions)
  end
  
  test "should make element questions" do
    @quiz = create(:new_quiz)
    question_maker = QuestionMaker.new(quiz: @quiz)
    @element_quiz.make_questions(question_maker)
    assert_equal @quiz.questions.count, @quiz_type.num_questions
    
    @quiz.questions.each do |question|
      assert_equal question.quiz_id, @quiz.id
      assert_equal question.answered, false
      assert_match (/What is the element with the symbol [A-Z][a-z]?[?]/), question.prompt
      assert_equal question.answers.count, 4
      assert_equal question.answers.map { |answer| answer.text }.uniq.length, 4
      assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
      question.answers.each do |answer|
        assert_not_equal answer.text.length, 0
        assert_equal answer.question_id, question.id
      end
    end
  end
  
  test "should get question_index" do
    question_index = @element_quiz.question_index
    assert_equal question_index.count, question_index.uniq.count
    assert_operator question_index.count, :>=, 10
  end

end
