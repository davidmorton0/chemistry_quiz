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
  
  def labeltext(question, answer)
    question.prompt.match("What is the chemical formula") ? format_formula(answer.text) : answer.text
  end
  
  def format_formula(formula)
    formula.gsub(/(\d+)/, '<sub>\1</sub>')
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