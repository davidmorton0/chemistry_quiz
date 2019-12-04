class QuizSelector
  def initialize(quiz_type, quiz)
    if quiz_type.name == "Chemical Symbol Quiz"
      SymbolQuiz.new(quiz_type, quiz.id).make_symbol_quiz
    elsif quiz_type.name == "Chemical Element Quiz"
      quiz.make_element_quiz(quiz_type, quiz.id)
    elsif quiz_type.name == "Substance Properties Quiz"
      quiz.make_substance_quiz(quiz_type, quiz.id)
    elsif quiz_type.name == "Mole Calculation Quiz"
      quiz.make_moles_quiz(quiz_type, quiz.id)
    end
  end
end