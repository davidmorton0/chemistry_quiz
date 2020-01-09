class QuestionMaker
  
  attr_accessor :quiz, :question
  
  def initialize(quiz:)
    @quiz = quiz
  end
  
  def make_question(question_info)
    @question = Question.create(
      prompt: question_info[:prompt],
      correct_answer: question_info[:correct_answer],
      quiz_id: quiz.id,
      answered: false )
    question_info[:answers].each do |answer|
      make_answer(answer)
    end
  end
  
  def make_answer(answer)
    Answer.create(
      text: answer,
      question_id: question.id)
  end
end