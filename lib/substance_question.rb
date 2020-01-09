class SubstanceQuestion
  include SubstanceData
  include FakeNames
  
  NAMES = (SUBSTANCE.map { |s| s[:name] } + FAKENAMES).uniq
  ANSWERS = 4
  
  #what name
  def substance_name_question(question_index)
    question = NamesSelector.new(NAMES, SUBSTANCE[question_index][:name])
    
    #substances_same_letter = (names_starting(substance[:name][0]) + names_starting(substance[:formula][0])).uniq
    #substances_different_letter = NAMES - substances_same_letter
    
    {
      prompt: "What is the name of the substance with the formula #{SUBSTANCE[question_index][:formula]}?",
      correct_answer: question.correct_answer,
      answers: question.answers(ANSWERS, 50)
    }
  end
  
  #what type of bonding question
  def bonding_question(question_index)
    substance = SUBSTANCE[question_index]
    {
      prompt: "What type of bonding is found in #{substance[:name]}?",
      correct_answer: substance[:bonding],
      answers: ["Giant Molecular", "Ionic", "Metallic", "Simple Molecular"]
    }
  end
  
  #what state
  def state_question(question_index)
    substance = SUBSTANCE[question_index]
    {
      prompt: "What state is #{substance[:name]} at RTP?",
      correct_answer: substance[:state],
      answers: [ "Solid", "Liquid", "Gas" ]
    }
  end
  
  #what colour
  def colour_question(question_index)
    substance = SUBSTANCE[question_index]
    answers = (SUBSTANCE.map{ |sub| sub[:colour] } - [substance[:colour]]).uniq.take(3)
    answers.push(substance[:colour]).shuffle
    {
      prompt: "What colour is #{substance[:name]}?",
      correct_answer: substance[:colour],
      answers: answers
    }
  end
  
  #what formula
  def formula_question(question_index)
    substance = SUBSTANCE[question_index]
    molecule = substance[:entity] == "Molecule" ? "a molecule of " : ""
    answers = modify_formulas(substance[:formula])
    answers.push(substance[:formula]).shuffle
    {
      prompt: "What is the chemical formula for #{molecule}#{substance[:name]}?",
      correct_answer: substance[:formula],
      answers: answers
    }
  end
  
  def modify_formulas(formula)
    elements = formula.scan(/([A-Z][a-z]?)([0-9]*)/)
    amounts = elements.map{ |element| element[1].empty? ? 1 : element[1].to_i }
    a = ([1,2,3,4].repeated_permutation(amounts.length).to_a - [amounts]).shuffle.take(3)
    formulas = []
    (0..2).each do |x|
      formulas.push(
        a[x]
          .each
          .with_index
          .map{ | i,j | "#{elements[j][0]}#{i==1?"":i}" }
          .join(''))
    end
    return formulas
  end
end