class MolesQuestion
  include ElementData
  
  ANSWERS = 4
  
  def moles_question(question_index)
    element = ELEMENT[question_index]
    mass = ((0.1 + rand(100) / 10) * element[:ar]).round(2)
    
    correct_answer = (mass / element[:ar]).round(2)

    answers = [ (mass * element[:ar]).round(1).to_s,
              (mass * element[:ar] / 2).round(1).to_s,
              (element[:ar] / mass).round(1).to_s,
              (correct_answer + element[:ar]).to_s ] - [correct_answer.to_s]
    answers = (answers.uniq.take(ANSWERS - 1) + [correct_answer.to_s]).shuffle
    {
      prompt: "How many moles of atoms are there in #{mass}g of #{ELEMENT[question_index][:name]}?",
      correct_answer: correct_answer.to_s,
      answers: answers
    }
  end
end