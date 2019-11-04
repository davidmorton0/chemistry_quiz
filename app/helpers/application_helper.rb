require 'chem_data.rb'

module ApplicationHelper

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
    q = rand(test_elements - 1)
    #q = 25
    #first letter of element
    #first two letters of element
    #first letter and other letter of element
    #One letter
    #Two other letters
    possible_answers = [  ChemData::Element[q][:Symbol],
                          ChemData::Element[q][:Name][0],
                          ChemData::Element[q][:Name][0,2],
                          ChemData::Element[q][:Name][0] +
                            ChemData::Element[q][:Name][ChemData::Element[q][:Name].length - 1],
                          ChemData::Element[q][:Name][0] +
                            ChemData::Element[q][:Name][rand(ChemData::Element[q][:Name].length - 3) + 2],
                          ChemData::Element[q][:Name][rand(ChemData::Element[q][:Name].length)].upcase,
                          (65 + rand(26)).chr,
                          (65 + rand(26)).chr + (97 + rand(26)).chr ]
    while possible_answers.uniq.length < 4
      possible_answers.push((65 + rand(26)).chr + (97 + rand(26)).chr)
    end
    data = {
        question: "What is the chemical symbol for #{ChemData::Element[q][:Name]}?",
        answers: ((possible_answers.uniq - [ChemData::Element[q][:Symbol]]).shuffle.take(answers - 1) + [ChemData::Element[q][:Symbol]]).shuffle,
        correct_answer: ChemData::Element[q][:Symbol],
        possible_answers: possible_answers
      }
    data
  end 
end
