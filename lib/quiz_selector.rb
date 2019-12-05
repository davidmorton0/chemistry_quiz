class QuizSelector
  def initialize(quiz_type, quiz)
    if quiz_type.name == "Chemical Symbol Quiz"
      SymbolQuiz.make_symbol_quiz(quiz)
    elsif quiz_type.name == "Chemical Element Quiz"
      ElementQuiz.make_element_quiz(quiz)
    elsif quiz_type.name == "Substance Properties Quiz"
      SubstanceQuiz.make_substance_quiz(quiz_type, quiz.id)
    elsif quiz_type.name == "Mole Calculation Quiz"
      MolesQuiz.make_moles_quiz(quiz_type, quiz.id)
    end
  end
end