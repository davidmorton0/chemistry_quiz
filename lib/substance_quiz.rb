module SubstanceQuiz

  def make_substance_quiz(quiz_type, quiz_id)
=begin
    if quiz_type.level == 1
      question_index = [0, 1, 2, 5, 6, 7, 8, 9, 10, 11]
    elsif quiz_type.level == 2
      question_index = (0..29).to_a
    elsif quiz_type.level == 3
      question_index = (0..ELEMENTS - 1).to_a
    end
=end
    num_questions = quiz_type.num_questions
    questions = (0..ChemData::SUBSTANCE.length - 1).to_a.shuffle.take(num_questions)
    
    (0..1).each do |x|
      bonding_question(quiz_id, questions[x])
    end
    
    (2..3).each do |x|
      state_question(quiz_id, questions[x])
    end
    
    (4..5).each do |x|
      colour_question(quiz_id, questions[x])
    end
    
    (6..9).each do |x|
      formula_question(quiz_id, questions[x])
    end
  end
  
  #what name
  
  #what type of bonding
  def bonding_question(quiz_id, question_index)
    substance = ChemData::SUBSTANCE[question_index]
    question = Question.new(
      prompt: "What type of bonding is found in #{substance[:name]}?",
      correct_answer: substance[:bonding],
      quiz_id: quiz_id,
      answered: false
    )
    question.save
    
    answers = ["Giant Molecular", "Ionic", "Metallic", "Simple Molecular"]
    (0..3).each do |a|
      answer = Answer.new
      answer.text = answers[a]
      answer.question = question
      answer.save
    end
    return question
  end
  
  #what state
  def state_question(quiz_id, question_index)
    substance = ChemData::SUBSTANCE[question_index]
    
    question = Question.new(
      prompt: "What state is #{substance[:name]} at RTP?",
      correct_answer: substance[:state],
      quiz_id: quiz_id,
      answered: false
    )
    question.save
    
    answers = ["Gas", "Liquid", "Solid"]
    (0..2).each do |a|
      answer = Answer.new
      answer.text = answers[a]
      answer.question = question
      answer.save
    end
    return question
  end
  
  #what colour
  def colour_question(quiz_id, question_index)
    substance = ChemData::SUBSTANCE[question_index]
    
    question = Question.new(
      prompt: "What colour is #{substance[:name]}?",
      correct_answer: substance[:colour],
      quiz_id: quiz_id,
      answered: false
    )
    question.save
    
    answers = (ChemData::SUBSTANCE.map{ |sub| sub[:colour] } - [substance[:colour]]).uniq.take(3)
    answers.push(question.correct_answer).shuffle
    (0..3).each do |a|
      answer = Answer.new
      answer.text = answers[a]
      answer.question = question
      answer.save
    end
    return question
  end
  
  #what formula
  def formula_question(quiz_id, question_index)
    substance = ChemData::SUBSTANCE[question_index]
    molecule = substance[:entity] == "Molecule" ? "a molecule of " : ""
    
    question = Question.new(
      prompt: "What is the chemical formula for #{molecule}#{substance[:name]}?",
      correct_answer: substance[:formula],
      quiz_id: quiz_id,
      answered: false
    )
    question.save
    
    answers = modify_formulas(substance[:formula])
    answers.push(substance[:formula]).shuffle
    (0..3).each do |a|
      answer = Answer.new
      answer.text = answers[a]
      answer.question = question
      answer.save
    end
    return question
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