require 'chem_data.rb'

module QuesGen
  ELEMENTS = 98
  ANSWERS = 4
  
  def symbol_question(quiz_id)
    
    #select element for question
    e = rand(ELEMENTS - 1)
    possible_answers = [  ChemData::Element[e][:Symbol],    #correct answer
                          ChemData::Element[e][:Name][0],   #first letter of element
                          ChemData::Element[e][:Name][0,2], #first two letters of element
                          ChemData::Element[e][:Name][0] +
                            ChemData::Element[e][:Name][ChemData::Element[e][:Name].length - 1],  #first letter and last letter of element
                          ChemData::Element[e][:Name][0] +
                            ChemData::Element[e][:Name][rand(ChemData::Element[e][:Name].length - 3) + 2],  #first letter and other letter of element
                          ChemData::Element[e][:Name][rand(ChemData::Element[e][:Name].length)].upcase,
                          (65 + rand(26)).chr,              #random letter
                          (65 + rand(26)).chr + (97 + rand(26)).chr ]   #Two random letters
                          
    #add additional answers if needed
    while possible_answers.uniq.length < ANSWERS
      possible_answers.push((65 + rand(26)).chr + (97 + rand(26)).chr)
    end
    
    answers = ((possible_answers.uniq - [ChemData::Element[e][:Symbol]]).shuffle.take(ANSWERS - 1) + [ChemData::Element[e][:Symbol]]).shuffle
    
    question = Question.new(
      prompt: "What is the chemical symbol for #{ChemData::Element[e][:Name]}?",
      answer_A: answers[0],
      answer_B: answers[1],
      answer_C: answers[2],
      answer_D: answers[3],
      correct_answer: ChemData::Element[e][:Symbol],
      quiz: Quiz.find(quiz_id),
      answered: false
    )
    question.save
  end
end