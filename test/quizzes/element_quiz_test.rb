require 'test_helper'

class ElementQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz = create(:new_quiz)
    @element_quiz = ElementQuiz.new(@quiz)
  end
  
  test "should make element quiz" do
    assert @element_quiz.quiz === @quiz
    @element_quiz.make_quiz((0..9).to_a)
    assert_equal @quiz.questions.count, @quiz.quiz_type.num_questions
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
    (1..3).each do |n|
      question_index = @element_quiz.question_index(n)
      assert_equal question_index.count, question_index.uniq.count
      assert_operator question_index.count, :>=, 10
    end
  end
  
  test "should make element question" do
    question = ElementQuiz.new(@quiz).element_question(1)
    assert_equal "What is the element with the symbol He?", question[:prompt]
    assert_equal "Helium", question[:correct_answer]
    assert_equal question[:answers].count, 4
  end
  
  test "should make element question answers" do
    question = ElementQuiz.new(@quiz).element_question(1)
    assert_equal question[:answers].count, 4
    assert_equal question[:answers].select{ |answer| answer == "Helium" }.count, 1
    assert_equal question[:answers].select{ |answer| answer != "Helium" }.count, 3
    question[:answers].each do |answer|
        assert_match (/[A-Z][a-z]+/), answer
      end
  end
end
