class QuizMaker
  def initialize(user_id, quiz_type_id)
    @quiz = Quiz.new(
      score: 0,
      user_id: user_id,
      quiz_type_id: quiz_type_id)
  end
  def make_new_quiz
    QuizSelector.new(@quiz)
    @quiz.save
  end
end