class QuizAnswerer
  
  attr_accessor :quiz, :answers
  
  def initialize(quiz:, answers:)
    @quiz = quiz
    @answers = answers || {}
  end
  
  def fill_answers(answer:)
    if answer == "all"
      quiz.questions.each do |question|
        fill_answer(question.id.to_s)
      end
    elsif !answers[answer]
      fill_answer(answer)
    end
  end
  
  def fill_answer(id)
    if !answers[id]
      answers[id] = ""
    end
  end
  
  def answer_quiz
    quiz.questions.each do |question|
      if answers[question.id.to_s]
        question.answer_question(answers[question.id.to_s])
      end
    end
  end
  
end