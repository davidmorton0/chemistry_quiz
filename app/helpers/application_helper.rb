require 'chem_data.rb'

module ApplicationHelper
  class Question
    def initialize(prompt, possible_answers, correct_answer)
      @prompt = prompt
      @possible_answers = possible_answers
      @correct_answer = correct_answer
    end
  end

  def full_title(page_title = '')
    base_title = "Chemistry Quiz"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def question_data()
    test_elements = 98
    answers = 4
    #select element for question
    q = rand(test_elements - 1)
    possible_answers = [  ChemData::Element[q][:Symbol],    #correct answer
                          ChemData::Element[q][:Name][0],   #first letter of element
                          ChemData::Element[q][:Name][0,2], #first two letters of element
                          ChemData::Element[q][:Name][0] +
                            ChemData::Element[q][:Name][ChemData::Element[q][:Name].length - 1],  #first letter and last letter of element
                          ChemData::Element[q][:Name][0] +
                            ChemData::Element[q][:Name][rand(ChemData::Element[q][:Name].length - 3) + 2],  #first letter and other letter of element
                          ChemData::Element[q][:Name][rand(ChemData::Element[q][:Name].length)].upcase,
                          (65 + rand(26)).chr,              #random letter
                          (65 + rand(26)).chr + (97 + rand(26)).chr ]   #Two random letters
    #add additional answers if less than 4
    while possible_answers.uniq.length < 4
      possible_answers.push((65 + rand(26)).chr + (97 + rand(26)).chr)
    end
    Question.new(
      "What is the chemical symbol for #{ChemData::Element[q][:Name]}?",
      ((possible_answers.uniq - [ChemData::Element[q][:Symbol]]).shuffle.take(answers - 1) + [ChemData::Element[q][:Symbol]]).shuffle,
      ChemData::Element[q][:Symbol],
    )
  end 
end
