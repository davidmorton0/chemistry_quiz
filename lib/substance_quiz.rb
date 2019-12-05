class SubstanceQuiz

  def self.make_substance_quiz(quiz_type, quiz_id)
    num_questions = quiz_type.num_questions

    if quiz_type.level == 1
      questions = (0..ChemData::SUBSTANCE.length - 1).to_a.shuffle.take(num_questions)
    end

    (0..1).each do |x|
      question_info = bonding_question(questions[x])
      Quiz.find(quiz_id).make_question(question_info)
    end
    (2..3).each do |x|
      question_info = state_question(questions[x])
      Quiz.find(quiz_id).make_question(question_info)
    end
    (4..5).each do |x|
      question_info = colour_question(questions[x])
      Quiz.find(quiz_id).make_question(question_info)
    end
    (6..7).each do |x|
      question_info = formula_question(questions[x])
      Quiz.find(quiz_id).make_question(question_info)
    end
    (8..9).each do |x|
      question_info = substance_name_question(questions[x])
      Quiz.find(quiz_id).make_question(question_info)
    end
  end
  
  #what name
  def self.substance_name_question(question_index)
    substance = ChemData::SUBSTANCE[question_index]
    substances = ChemData::SUBSTANCE.map { |s| s[:name] } + ChemData::FAKENAMES - [substance[:name]]
    substances_same_letter = (substances.select {|s| s.match(substance[:name][0])} + substances.select {|s| s.match(substance[:formula][0])}).uniq
    substances_different_letter = substances - substances_same_letter
    n = [rand(4), substances_same_letter.length].min
    answers = substances_same_letter.shuffle.take(n) + substances_different_letter.shuffle.take(3 - n) + [substance[:name]]
    answers.shuffle!
    
    {
      prompt: "What is the name of the substance with the formula #{substance[:formula]}?",
      correct_answer: substance[:name],
      answers: answers
    }
  end
  
  #what type of bonding question
  def self.bonding_question(question_index)
    substance = ChemData::SUBSTANCE[question_index]
    {
      prompt: "What type of bonding is found in #{substance[:name]}?",
      correct_answer: substance[:bonding],
      answers: ["Giant Molecular", "Ionic", "Metallic", "Simple Molecular"]
    }
  end
  
  #what state
  def self.state_question(question_index)
    substance = ChemData::SUBSTANCE[question_index]
    {
      prompt: "What state is #{substance[:name]} at RTP?",
      correct_answer: substance[:state],
      answers: ["Gas", "Liquid", "Solid"]
    }
  end
  
  #what colour
  def self.colour_question(question_index)
    substance = ChemData::SUBSTANCE[question_index]
    answers = (ChemData::SUBSTANCE.map{ |sub| sub[:colour] } - [substance[:colour]]).uniq.take(3)
    answers.push(substance[:colour]).shuffle
    {
      prompt: "What colour is #{substance[:name]}?",
      correct_answer: substance[:colour],
      answers: answers
    }
  end
  
  #what formula
  def self.formula_question(question_index)
    substance = ChemData::SUBSTANCE[question_index]
    molecule = substance[:entity] == "Molecule" ? "a molecule of " : ""
    answers = modify_formulas(substance[:formula])
    answers.push(substance[:formula]).shuffle
    {
      prompt: "What is the chemical formula for #{molecule}#{substance[:name]}?",
      correct_answer: substance[:formula],
      answers: answers
    }
  end
  
  def self.modify_formulas(formula)
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