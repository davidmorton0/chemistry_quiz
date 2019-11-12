module QuizzesHelper
  
  def make_new_quiz(user_id)
    quiz = Quiz.new
    quiz.title = "Chemical Symbol Quiz"
    quiz.num_questions = 10
    quiz.user_id = user_id
    quiz.score = 0
    quiz.save
    (1..quiz.num_questions).each do
      symbol_question(quiz.id)
    end
    return quiz
  end
  
end
