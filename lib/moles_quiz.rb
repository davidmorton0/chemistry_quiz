class MolesQuiz
  
  attr_accessor :level, :num_questions
  
  def initialize(level:, num_questions:)
    @level = level
    @num_questions = num_questions
  end
  
  def question_index
    if level == 1
      [0, 1, 2, 5, 6, 7, 8, 9, 10, 11]
    elsif level == 2
      (0..29).to_a
    elsif level == 3
      (0..117).to_a
    end
  end
  
  def make_questions(question_maker)
    question_index.shuffle.take(num_questions).each do |question|
      question_maker.make_question(MolesQuestion.new.moles_question(question))
    end
  end

end