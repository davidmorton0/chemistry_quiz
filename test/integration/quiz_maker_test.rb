require 'test_helper'

class QuizMakerTest < ActionDispatch::IntegrationTest
  
  QUIZTYPE_CLASSES = [  ["Chemical Symbol Quiz", "SymbolQuiz"],
                        ["Chemical Element Quiz", "ElementQuiz"],
                        ["Substance Properties Quiz", "SubstanceQuiz"],
                        ["Mole Calculation Quiz", "MolesQuiz"]  ]
  
  test "should initialize QuizMaker" do
    @user = create(:new_user)
    @quiz_type = create(:new_quiz_type)
    quiz_maker = QuizMaker.new(@user.id, @quiz_type.id)
    assert_equal quiz_maker.quiz.user_id, @user.id
    assert_equal quiz_maker.quiz.quiz_type_id, @quiz_type.id
    assert_equal quiz_maker.quiz.score, 0
  end
  
  test "should select quiz types" do
    @user = create(:new_user)
    @quiz_type = create(:new_quiz_type)
    quiz_maker = QuizMaker.new(@user.id, @quiz_type.id)
    QUIZTYPE_CLASSES.each do |quiz_type_class|
      quiz_maker.quiz.quiz_type.name = quiz_type_class[0]
      selected_quiz = quiz_maker.select_quiz
      assert_equal selected_quiz.class.name, quiz_type_class[1]
    end
  end
  
=begin
  test "should select questions" do
    num_questions = 10
    select_questions = QuizMaker.new.select_questions((0..50).to_a, num_questions)
    assert_equal select_questions.count, select_questions.uniq.count
    assert_equal select_questions.count, num_questions
  end
=end
end