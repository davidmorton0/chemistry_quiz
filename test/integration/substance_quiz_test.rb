require 'test_helper'

class SubstanceQuizTest < ActionDispatch::IntegrationTest
  
  test "should make substance quiz" do
=begin
    quiz_type = quiz_types(:four)
    user = users(:mark)
    quiz = Quiz.new
    quiz.save
    quiz.make_new_quiz(quiz_type, user.id)
    assert_equal quiz.questions.count, quiz_type.num_questions
    assert_equal quiz.questions.map { |question| question.prompt }.uniq.length, quiz.questions.count
    quiz.questions.each do |question|
      assert_equal question.quiz_id, quiz.id
      assert_equal question.answered, false
    end
=end
  end
  
  test "should make substance name question" do
=begin
    question_info = SubstanceQuiz.substance_name_question(19)
    assert_equal question_info[:prompt], "What is the name of the substance with the formula H2O?"
    assert_equal question_info[:correct_answer], "Water"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    question_info[:answers] do |answer|
      assert_match (/[A-Z][a-z]+/), answer
    end
=end
  end
  
  test "should make bonding type question" do
    question_info = SubstanceQuiz.bonding_question(19)
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
    question_info = SubstanceQuiz.state_question(19)
    assert_equal question_info[:prompt], "What state is Water at RTP?"
    assert_equal question_info[:correct_answer], "Liquid"
    assert_equal question_info[:answers].length, 3
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    answers = ["Gas", "Liquid", "Solid"]
    question_info[:answers].each.with_index do |answer, i|
      assert_equal answer, answers[i]
    end
  end
  
  test "should make colour question" do
    question_info = SubstanceQuiz.colour_question(19)
    assert_equal question_info[:prompt], "What colour is Water?"
    assert_equal question_info[:correct_answer], "Colourless"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    question_info[:answers].each do |answer|
      assert_not_nil answer
    end
  end
  
  test "should make formula question" do
    question_info = SubstanceQuiz.formula_question(21)
    assert_equal question_info[:prompt], "What is the chemical formula for Sodium oxide?"
    question_info = SubstanceQuiz.formula_question(19)
    assert_equal question_info[:prompt], "What is the chemical formula for a molecule of Water?"
    assert_equal question_info[:correct_answer], "H2O"
    assert_equal question_info[:answers].length, 4
    assert_equal question_info[:answers].select { |answer| answer == question_info[:correct_answer] }.length, 1
    question_info[:answers].each do |answer|
      assert_match (/H[\d]?O[\d]?/), answer
    end
  end
  
  test "should make different formulas" do
    formulas = SubstanceQuiz.modify_formulas("HF")
    formulas.each do |formula|
      assert_match (/H[2-4]?F[2-4]?/), formula
    end
  end
end
