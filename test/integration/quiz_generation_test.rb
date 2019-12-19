require 'test_helper'

class QuizGenerationTest < ActionDispatch::IntegrationTest

=begin
  test "gets question data" do
    @quiz = create(:new_quiz)
    question = SymbolQuiz.new(@quiz)symbol_question(100, 90)
    assert_not_empty question.prompt
    assert_equal question.answered, false
    assert_not_nil question.correct_answer, false
    assert_nil question.chosen_answer
    assert_equal question.answered, false
=end
  
  test "makes 10 question test" do
=begin
    @quiztype = create(:cs_quiz_type)
    quiz = Quiz.new
    quiz.make_new_quiz(@quiztype, 2)
    assert_equal quiz.questions.count, @quiztype.num_questions
    assert_equal quiz.answers.count, @quiztype.num_questions * 4
    assert_equal quiz.user_id, 2
    assert_equal quiz.score, 0
=end
  end
  
  test "all questions different with 4 answers" do
=begin
    @quiztype = quiz_types(:one)
    quiz = Quiz.new
    quiz.make_new_quiz(@quiztype, 2)
    quiz.questions.each do |question|
      assert_equal question.answers.count, 4
      question_count = 0
      quiz.questions.each do |q|
        question_count += 1 if question.prompt == q.prompt 
      end
      assert_equal question_count, 1
    end
=end
  end
end