require 'test_helper'

class SubstanceQuizTest < ActionDispatch::IntegrationTest
  
  def setup
    @quiz = create(:new_quiz)
    @substance_quiz = SubstanceQuiz.new(@quiz)
  end
  
  test "should make substance quiz" do
    assert @substance_quiz.quiz === @quiz
    @substance_quiz.make_quiz((0..9).to_a)
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
    (1..3).each do |n|
      question_index = @substance_quiz.question_index(n)
      assert_equal question_index.count, question_index.uniq.count
      assert_operator question_index.count, :>=, 10
    end
  end

  test "should make substance name question" do
    question_info = @substance_quiz.substance_name_question(19)
    assert_equal question_info[:prompt], "What is the name of the substance with the formula H2O?"
    assert_equal question_info[:correct_answer], "Water"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    question_info[:answers] do |answer|
      assert_match (/[A-Z][a-z]+/), answer
    end
  end
 
  test "should make bonding type question" do
    question_info = @substance_quiz.bonding_question(19)
    assert_equal question_info[:prompt], "What type of bonding is found in Water?"
    assert_equal question_info[:correct_answer], "Simple Molecular"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    answers = ["Giant Molecular", "Ionic", "Metallic", "Simple Molecular"]
    question_info[:answers].each.with_index do |answer, i|
      assert_equal answer, answers[i]
    end
  end
 
  test "should make state question" do
    question_info = @substance_quiz.state_question(19)
    assert_equal question_info[:prompt], "What state is Water at RTP?"
    assert_equal question_info[:correct_answer], "Liquid"
    assert_equal question_info[:answers].length, 3
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    answers = [ "Solid", "Liquid", "Gas" ]
    question_info[:answers].each.with_index do |answer, i|
      assert_equal answer, answers[i]
    end
  end
   
  test "should make colour question" do
    question_info = @substance_quiz.colour_question(19)
    assert_equal question_info[:prompt], "What colour is Water?"
    assert_equal question_info[:correct_answer], "Colourless"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    question_info[:answers].each do |answer|
      assert_not_nil answer
    end
  end
 
  test "should make formula question" do
    question_info = @substance_quiz.formula_question(21)
    assert_equal question_info[:prompt], "What is the chemical formula for Sodium oxide?"
    question_info = @substance_quiz.formula_question(19)
    assert_equal question_info[:prompt], "What is the chemical formula for a molecule of Water?"
    assert_equal question_info[:correct_answer], "H2O"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    question_info[:answers].each do |answer|
      assert_match (/H[\d]?O[\d]?/), answer
    end
  end

  test "should make different formulas" do
    formulas = @substance_quiz.modify_formulas("HF")
    formulas.each do |formula|
      assert_match (/H[2-4]?F[2-4]?/), formula
    end
  end
  
end
