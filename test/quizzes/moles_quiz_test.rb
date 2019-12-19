require 'test_helper'

class MolesQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz = create(:new_quiz)
    @moles_quiz = MolesQuiz.new(@quiz)
  end
  
  test "should make moles quiz" do
    assert @moles_quiz.quiz === @quiz
    @moles_quiz.make_quiz((0..9).to_a)
    assert_equal @quiz.questions.count, @quiz.quiz_type.num_questions
    @quiz.questions.each do |question|
      assert_equal question.quiz_id, @quiz.id
      assert_equal question.answered, false
      assert_match (/How many moles of atoms are there in [\d.]+g of [A-Z][a-z]+[?]/), question.prompt
      assert_equal question.answers.count, 4
      assert_equal question.answers.map { |answer| answer.text }.uniq.length, 4
      assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
      question.answers.each do |answer|
        assert_match (/[\d.]+/), answer.text
        assert_equal answer.question_id, question.id
      end
    end
  end
  
  test "should get question_index" do
    (1..3).each do |n|
      question_index = @moles_quiz.question_index(n)
      assert_equal question_index.count, question_index.uniq.count
      assert_operator question_index.count, :>=, 10
    end
  end
  
  test "should make moles question" do
    question = MolesQuiz.new(@quiz).moles_question(1)
    assert_match (/How many moles of atoms are there in [\d.]+g of Helium[?]/), question[:prompt]
    assert_match (/[\d.]+/), question[:correct_answer]
    assert_equal question[:answers].count, 4
  end
  
  test "should make moles question answers" do
    question = MolesQuiz.new(@quiz).moles_question(1)
    assert_equal question[:answers].count, 4
    assert_equal question[:answers].select{ |answer| answer == question[:correct_answer] }.count, 1
    assert_equal question[:answers].select{ |answer| answer != question[:correct_answer] }.count, 3
    question[:answers].each do |answer|
        assert_match (/[\d.]+/), answer
      end
  end
end
