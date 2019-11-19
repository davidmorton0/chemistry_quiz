require 'chem_data.rb'

module QuizzesHelper
  
  def make_new_quiz(quiz_type, user_id)
    quiz = Quiz.create!(
      quiz_type_id: quiz_type.id,
      user_id: user_id,
      score: 0)
    quiz.save
    
    if quiz_type.name == "Chemical Symbol Quiz"
      make_symbol_quiz(quiz_type, quiz.id)
    end
    
    return quiz
  end
  
  def make_symbol_quiz(quiz_type, quiz_id)
    if quiz_type.level == 1
      question_index = [0, 1, 2, 5, 6, 7, 8, 9, 10, 11]
    elsif quiz_type.level == 2
      question_index = (0..29).to_a
    elsif quiz_type.level == 3
      question_index = (0..97).to_a
    end
    num_questions = quiz_type.num_questions
    questions = question_index.shuffle.take(num_questions)
    (0..num_questions - 1).each do |x|
      symbol_question(quiz_id, questions[x])
    end
    
  end
  
    ELEMENTS = 98
  ANSWERS = 4
  
  def symbol_question(quiz_id, question_index)
    
    #select element for question
    e = question_index
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
      correct_answer: ChemData::Element[e][:Symbol],
      quiz: Quiz.find(quiz_id),
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