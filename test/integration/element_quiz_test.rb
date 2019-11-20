require 'test_helper'

class ElementQuizTest < ActionDispatch::IntegrationTest
  
  test "should make element quiz" do
    quiz_type = quiz_types(:two)
    user = users(:mark)
    quiz = Quiz.new
    quiz.save
    quiz.make_new_quiz(quiz_type, user.id)
    assert_equal quiz.questions.count, quiz_type.num_questions
    quiz.questions.each do |question|
      assert_equal question.quiz_id, quiz.id
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
  
end
