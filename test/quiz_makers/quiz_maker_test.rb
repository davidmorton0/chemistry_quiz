require 'test_helper'

class QuizMakerTest < ActionDispatch::IntegrationTest
  
  QUIZTYPE_CLASSES = [  { name: "Chemical Symbol Quiz", class: SymbolQuiz },
                        { name: "Chemical Element Quiz", class: ElementQuiz },
                        { name: "Substance Properties Quiz", class: SubstanceQuiz },
                        { name: "Mole Calculation Quiz", class: MolesQuiz }  ]
  def setup
    @quiz = create(:new_quiz)
    @quiz_type = @quiz.quiz_type
    @quiz_maker = QuizMaker.new(quiz: @quiz)
  end
  
  test "should initialize QuizMaker" do
    assert_equal @quiz_maker.quiz, @quiz
    assert_equal @quiz_maker.quiz_type, @quiz_type
  end
  
 
  test "should select quiz types" do
    QUIZTYPE_CLASSES.each do |quiz_type|
      @quiz_type.name = quiz_type[:name]
      selected_quiz = @quiz_maker.select_quiz 
      assert selected_quiz.is_a? quiz_type[:class]
      assert_equal selected_quiz.level, @quiz_type.level
      assert_equal selected_quiz.num_questions, @quiz_type.num_questions
    end
  end
  
  test "should make questions" do
    QUIZTYPE_CLASSES.each do |quiz_type|
      @quiz = create(:new_quiz)
      @quiz_type = @quiz.quiz_type
      @quiz_maker = QuizMaker.new(quiz: @quiz)
      @quiz_type.name = quiz_type[:name]
      assert_equal @quiz.questions.count, 0
      @quiz_maker.make_new_quiz
      assert_equal @quiz.questions.count, @quiz_type.num_questions
      assert_equal @quiz.questions.count, @quiz.questions.uniq.count
    end
  end

end