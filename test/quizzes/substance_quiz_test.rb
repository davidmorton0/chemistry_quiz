require 'test_helper'

class SubstanceQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz_type = create(:new_quiz_type)
    @substance_quiz = SubstanceQuiz.new(
                    level: @quiz_type.level,
                    num_questions: @quiz_type.num_questions)
  end

  test "should make substance questions" do
    @quiz = create(:new_quiz)
    question_maker = QuestionMaker.new(quiz: @quiz)
    @substance_quiz.make_questions(question_maker)
    assert_equal @quiz.questions.count, @quiz.quiz_type.num_questions
    @quiz.questions.each do |question|
      assert_equal question.quiz_id, @quiz.id
      assert_equal question.answered, false
      assert_not_nil question.prompt
      assert_operator question.answers.count, :<=, 4
      assert_operator question.answers.count, :>=, 3
      assert_equal question.answers.map { |answer| answer.text }.uniq.length, question.answers.count
      assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
      question.answers.each do |answer|
        assert_not_equal answer.text.length, 0
        assert_equal answer.question_id, question.id
      end
    end
  end
  
  test "should get question_index" do
    question_index = @substance_quiz.question_index
    assert_equal question_index.count, question_index.uniq.count
    assert_operator question_index.count, :>=, 10
  end

end
