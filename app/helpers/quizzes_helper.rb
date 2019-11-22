module QuizzesHelper
  def check(question, answer)
    check = answer.text == question.chosen_answer ? answer.text == question.correct_answer ? "\u{2714}" : "\u{274C}" : ""
  end
  
  def show_answered(question, answer)
    question.answered && (question.correct_answer == answer.text) ? "correct" : "incorrect"
  end
end