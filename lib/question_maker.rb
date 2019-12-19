class QuestionMaker
  
  def initialize(question_info, quiz)
    @question_info = question_info
    @quiz = quiz
  end
  
  def make_question
    @question = Question.create(
      prompt: @question_info[:prompt],
      correct_answer: @question_info[:correct_answer],
      quiz_id: @quiz.id,
      answered: false )
    make_answers
  end
  
  def make_answers
    @question_info[:answers].each do |answer|
      Answer.create(
        text: answer,
        question_id: @question.id)
    end
  end
end