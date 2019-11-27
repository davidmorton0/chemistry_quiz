require 'test_helper'

class SubstanceQuizTest < ActionDispatch::IntegrationTest
  
  test "should make substance quiz" do
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
  end
  
  test "should make bonding type question" do
    quiz = Quiz.new
    question = quiz.bonding_question(200, 19)
    assert_equal question.prompt, "What type of bonding is found in Water?"
    assert_equal question.correct_answer, "Simple Molecular"
    assert_equal question.quiz_id, 200
    assert_equal question.answered, false
    assert_equal question.answers.map { |answer| answer.text }.uniq.length, 4
    assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
    answers = ["Giant Molecular", "Ionic", "Metallic", "Simple Molecular"]
    question.answers.each.with_index do |answer, i|
      assert_equal answer.text, answers[i]
      assert_equal question.id, answer.question_id
    end
  end
  
  test "should make state question" do
    quiz = Quiz.new
    question = quiz.state_question(200, 19)
    assert_equal question.prompt, "What state is Water at RTP?"
    assert_equal question.correct_answer, "Liquid"
    assert_equal question.quiz_id, 200
    assert_equal question.answered, false
    assert_equal question.answers.map { |answer| answer.text }.uniq.length, 3
    assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
    answers = ["Gas", "Liquid", "Solid"]
    question.answers.each.with_index do |answer, i|
      assert_equal answer.text, answers[i]
      assert_equal question.id, answer.question_id
    end
  end
  
  test "should make colour question" do
    quiz = Quiz.new
    question = quiz.colour_question(200, 19)
    assert_equal question.prompt, "What colour is Water?"
    assert_equal question.correct_answer, "Colourless"
    assert_equal question.quiz_id, 200
    assert_equal question.answered, false
    assert_equal question.answers.map { |answer| answer.text }.uniq.length, 4
    assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
    question.answers do |answer|
      assert_not_nil answer.text
      assert_equal question.id, answer.question_id
    end
  end
  
  test "should make formula question" do
    quiz = Quiz.new
    question = quiz.formula_question(200, 21)
    assert_equal question.prompt, "What is the chemical formula for Sodium oxide?"
    question = quiz.formula_question(200, 19)
    assert_equal question.prompt, "What is the chemical formula for a molecule of Water?"
    assert_equal question.correct_answer, "H2O"
    assert_equal question.quiz_id, 200
    assert_equal question.answered, false
    assert_equal question.answers.map { |answer| answer.text }.uniq.length, 4
    assert_equal question.answers.select { |answer| answer.text == question.correct_answer }.length, 1
    question.answers do |answer|
      assert_match (/H[\d]?O[\d]?/), answer.text
      assert_equal question.id, answer.question_id
    end
  end
  
  test "should make different formulas" do
    quiz = Quiz.new
    formulas = quiz.modify_formulas("HF")
    formulas.each do |formula|
      assert_match (/H[2-4]?F[2-4]?/), formula
    end
  end
end
