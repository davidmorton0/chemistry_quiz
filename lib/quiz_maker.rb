class QuizMaker
  
  attr_accessor :quiz
  
  def initialize(user_id, quiz_type_id)
    @quiz = Quiz.new(
      score: 0,
      user_id: user_id,
      quiz_type_id: quiz_type_id)
  end
  
  def make_new_quiz
    selected_quiz = select_quiz
    questions = select_questions(selected_quiz.question_index(@quiz.quiz_type.level), @quiz.quiz_type.num_questions)
    selected_quiz.make_quiz(questions)
    @quiz.save
  end
  
  def select_quiz
    if @quiz.quiz_type.name == "Chemical Symbol Quiz"
      SymbolQuiz.new(@quiz)
    elsif @quiz.quiz_type.name == "Chemical Element Quiz"
      ElementQuiz.new(@quiz)
    elsif @quiz.quiz_type.name == "Substance Properties Quiz"
      SubstanceQuiz.new(@quiz)
    elsif @quiz.quiz_type.name == "Mole Calculation Quiz"
      MolesQuiz.new(@quiz)
    end
  end
  
  def select_questions(questions, num_questions)
    questions.shuffle.take(num_questions)
  end
  
end