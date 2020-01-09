class QuizMaker
  
  attr_accessor :quiz_type, :quiz
  
  def initialize(quiz:)
    @quiz = quiz
    @quiz_type = quiz.quiz_type
  end
  
  def make_new_quiz
    select_quiz.make_questions(QuestionMaker.new(quiz: quiz))
  end
  
  def select_quiz
    if @quiz_type.name == "Chemical Symbol Quiz"
      SymbolQuiz.new(level: quiz_type.level, num_questions: quiz_type.num_questions)
    elsif @quiz_type.name == "Chemical Element Quiz"
      ElementQuiz.new(level: quiz_type.level, num_questions: quiz_type.num_questions)
    elsif @quiz_type.name == "Substance Properties Quiz"
      SubstanceQuiz.new(level: quiz_type.level, num_questions: quiz_type.num_questions)
    elsif @quiz_type.name == "Mole Calculation Quiz"
      MolesQuiz.new(level: quiz_type.level, num_questions: quiz_type.num_questions)
    end
  end
end