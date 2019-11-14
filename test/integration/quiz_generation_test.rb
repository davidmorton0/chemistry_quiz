require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include QuestionGenerator
  include QuizzesHelper
  
  test "gets question data" do
    question = symbol_question(100, rand(98))
    assert_match "What is the chemical symbol for", question.prompt
    correct_count = 0
    question.answers.each do |answer|
      assert answer.text.length > 0
      assert answer.text.length < 3
      assert_match (/[A-Z][a-z]?/), answer.text
      answer_count = 0
      question.answers.each do |a|
        answer_count += 1 if answer.text == a.text 
      end
      assert_equal answer_count, 1
      correct_count += 1 if answer.text == question.correct_answer
    end
    assert_equal correct_count, 1
    assert_equal question.answered, false
    assert_nil question.chosen_answer
  end
  
  
  
  test "makes 10 question test" do
    quiz = make_new_quiz(1, 2)
    assert_equal quiz.questions.count, 10
    assert_equal quiz.user_id, 2
    assert_equal quiz.score, 0
  end
  
  test "all questions different with 4 answers" do
    quiz = make_new_quiz(1, 2)
    quiz.questions.each do |question|
      assert_equal question.answers.count, 4
      question_count = 0
      quiz.questions.each do |q|
        question_count += 1 if question.prompt == q.prompt 
      end
      assert_equal question_count, 1
    end
  end
end