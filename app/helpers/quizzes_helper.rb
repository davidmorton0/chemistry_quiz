module QuizzesHelper
  def check(question, answer)
    answer.text == question.chosen_answer ? answer.text == question.correct_answer ? "\u{2714}" : "\u{274C}" : ""
  end
  
  def show_answered(question, answer)
    question.answered ? (question.correct_answer == answer.text) ? "correct" : "incorrect" : "unanswered"
  end
  
  def checked(question, answer)
    answer.text == question.chosen_answer
  end
  
  def format_formula(formula)
    formula.gsub(/(\d+)/, '<sub>\1</sub>')
  end
  
  def show_high_score(quiz)
    show_high_score = Score.find_by(user_id: quiz.user, quiz_type_id: quiz.quiz_type)
    show_high_score ? show_high_score : ""
  end
  
  def labeltext(question, answer)
    question
      .prompt
      .match("What is the chemical formula") ? format_formula(answer.text) : answer.text
  end
  
  def questiontext(prompt)
    prompt.match("What is the name of the substance with the formula") ? format_formula(prompt) : prompt
  end
  
  def similar_quizzes(quiz_type)
    QuizType.where(name: @quiz.quiz_type.name)
  end
  
  def score(quiz)
    if quiz.questions.select { |question| question.answered == false }
      .length == 0
      "You scored: #{quiz.score}/#{quiz.quiz_type.num_questions}"
    else
      "Current Score: #{quiz.score}"
    end
  end
end