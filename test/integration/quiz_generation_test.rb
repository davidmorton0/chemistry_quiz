require 'test_helper'

class QuizGenerationTest < ActionDispatch::IntegrationTest

  test "gets question data" do
    question = SymbolQuestion.new.symbol_question(0)
    assert_not_empty question[:prompt]
    assert_not question[:answered]
    assert_not_nil question[:correct_answer]
    assert_nil question[:chosen_answer]
    assert_not question[:answered]
  end
 
  test "makes 10 question test" do
    @quiz_type = create(:new_quiz_type)
    @user = create(:new_user)
    log_in_as(@user)
    quiz = Quiz.create(user: @user, quiz_type: @quiz_type, score: 0)
    quiz.make_new_quiz
    assert_equal quiz.questions.count, @quiz_type.num_questions
    assert_equal quiz.answers.count, @quiz_type.num_questions * 4
    assert_equal quiz.user_id, @user.id
    assert_equal quiz.score, 0
  end
  
  test "all questions different with 4 answers" do
    @quiz_type = create(:new_quiz_type)
    @user = create(:new_user)
    log_in_as(@user)
    quiz = Quiz.create(user: @user, quiz_type: @quiz_type, score: 0)
    quiz.make_new_quiz
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