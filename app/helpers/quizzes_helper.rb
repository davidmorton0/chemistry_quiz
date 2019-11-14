module QuizzesHelper
  
  def make_new_quiz(type, user_id)
    quiz = Quiz.new
    quiz.quiz_type_id = type
    question_index = 97
    quiz.user_id = user_id
    quiz.score = 0
    quiz.save
    num_questions = QuizType.find(type).num_questions
    questions = (0..question_index).to_a.shuffle.take(num_questions)
    (0..num_questions - 1).each do |x|
      symbol_question(quiz.id, questions[x])
    end
    return quiz
  end
  
end
