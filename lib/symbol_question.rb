class SymbolQuestion
  include ElementData
  
  ANSWERS = 4
  
  def symbol_question(question_index)
    {
      prompt: "What is the chemical symbol for #{ELEMENT[question_index][:name]}?",
      correct_answer: ELEMENT[question_index][:symbol],
      answers: make_answers(ELEMENT[question_index][:name], ELEMENT[question_index][:symbol])
    }
  end
  
  def make_answers(element_name, correct_answer)
    possible_answers = [
      element_name[0],                      #first letter of element
      element_name[0,2],                    #first two letters of element
      element_name[0] + element_name[-1],   #first letter and last letter of element
      element_name[0] + element_name[rand(element_name.length - 3) + 2],  #first letter and other letter of element
      element_name[rand(element_name.length - 1) + 1].upcase, #random letter from element
      (65 + rand(26)).chr,                  #random letter
      (65 + rand(26)).chr + (97 + rand(26)).chr ] +  #Two random letters
      [correct_answer]
    
    #add additional answers if needed
    while possible_answers.uniq.length < ANSWERS
      possible_answers.push([((65 + rand(26)).chr + (97 + rand(26)).chr)])
    end
    
    ([correct_answer] + (possible_answers.uniq - [correct_answer]).shuffle.take(ANSWERS - 1)).shuffle
  end
end