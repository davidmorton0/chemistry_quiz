module QuizzesHelper
  
  def make_new_quiz(user_id)
    quiz = Quiz.new
    quiz.title = "Chemical Symbol Quiz"
    num_questions = 10
    question_index = 97
    quiz.user_id = user_id
    quiz.score = 0
    quiz.difficulty = 1
    quiz.save
    questions = (0..question_index).to_a.shuffle.take(num_questions)
    (0..num_questions - 1).each do |x|
      symbol_question(quiz.id, questions[x])
    end
    return quiz
  end
  
end
