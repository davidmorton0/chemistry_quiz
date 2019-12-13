class QuestionMaker
  def make_question(question_info)
    question = Question.new(
      prompt: question_info[:prompt],
      correct_answer: question_info[:correct_answer],
      quiz_id: id,
      answered: false )
    question.save
    question.make_answers(question_info[:answers])
  end
end