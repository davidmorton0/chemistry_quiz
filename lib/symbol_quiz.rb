module SymbolQuiz
  
  ELEMENTS = 118
  ANSWERS = 4

  def make_symbol_quiz(quiz_type, quiz_id)
    if quiz_type.level == 1
      question_index = [0, 1, 2, 5, 6, 7, 8, 9, 10, 11]
    elsif quiz_type.level == 2
      question_index = (0..29).to_a
    elsif quiz_type.level == 3
      question_index = (0..ELEMENTS - 1).to_a
    end
    num_questions = quiz_type.num_questions
    questions = question_index.shuffle.take(num_questions)
    (0..num_questions - 1).each do |x|
      symbol_question(quiz_id, questions[x])
    end
  end
  
  def symbol_question(quiz_id, question_index)
    element = ChemData::Element[question_index]
    correct_answer = element[:Symbol]

    possible_answers = [
      element[:Name][0],                        #first letter of element
      element[:Name][0,2],                      #first two letters of element
      element[:Name][0] + element[:Name][-1],   #first letter and last letter of element
      element[:Name][0] + element[:Name][rand(element[:Name].length - 3) + 2],  #first letter and other letter of element
      element[:Name][rand(element[:Name].length - 1) + 1].upcase, #random letter from element
      (65 + rand(26)).chr,                      #random letter
      (65 + rand(26)).chr + (97 + rand(26)).chr ] +  #Two random letters
      [correct_answer]
    
    #add additional answers if needed
    while possible_answers.uniq.length < ANSWERS
      possible_answers.push([((65 + rand(26)).chr + (97 + rand(26)).chr)])
    end
    
    answers = [correct_answer] + (possible_answers.uniq - [correct_answer]).shuffle.take(ANSWERS - 1)
    answers.shuffle!
    
    question = Question.new(
      prompt: "What is the chemical symbol for #{element[:Name]}?",
      correct_answer: correct_answer,
      quiz_id: quiz_id,
      answered: false
    )
    question.save
    
    (0..ANSWERS - 1).each do |a|
      answer = Answer.new
      answer.text = answers[a]
      answer.question = question
      answer.save
    end
    
    return question
  end
end