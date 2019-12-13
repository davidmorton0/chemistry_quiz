class QuizAnswerer
  def answer_quiz(quiz, answers)
    if answers
      quiz.questions.each do |question|
        if answers[question.id.to_s]
          question.answer_question(answers[question.id.to_s])
        end
      end
    end
  end
end