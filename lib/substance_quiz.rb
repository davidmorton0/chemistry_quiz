class SubstanceQuiz

  attr_accessor :level, :num_questions
  
  def initialize(level:, num_questions:)
    @level = level
    @num_questions = num_questions
  end
  
  def question_index
    (0..SubstanceQuestion::SUBSTANCE.length - 1).to_a
  end
  
  def make_questions(question_maker)
    questions = question_index.shuffle.take(num_questions)
    (0..1).each do |x|
      question_maker.make_question(SubstanceQuestion.new.bonding_question(questions[x]))
    end
    (2..3).each do |x|
      question_maker.make_question(SubstanceQuestion.new.state_question(questions[x]))
    end
    (4..5).each do |x|
      question_maker.make_question(SubstanceQuestion.new.colour_question(questions[x]))
    end
    (6..7).each do |x|
      question_maker.make_question(SubstanceQuestion.new.formula_question(questions[x]))
    end
    (8..9).each do |x|
      question_maker.make_question(SubstanceQuestion.new.substance_name_question(questions[x]))
    end
  end
end