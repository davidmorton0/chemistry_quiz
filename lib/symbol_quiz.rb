class SymbolQuiz
  include ElementData
  
  attr_accessor :quiz, :quiz_type, :num_questions
  
  ANSWERS = 4
  
  def initialize(quiz)
    @quiz = quiz
    @quiz_type = quiz.quiz_type
    @num_questions = @quiz_type.num_questions
  end
  
  def question_index(level)
    if level == 1
      [0, 1, 2, 5, 6, 7, 8, 9, 10, 11]
    elsif level == 2
      (0..29).to_a
    elsif level == 3
      (0..ELEMENT.length - 1).to_a
    end
  end
  
  def make_quiz(questions)
    questions.each do |question|
      question_info = symbol_question(question)
      QuestionMaker.new(question_info, @quiz).make_question
    end
  end
  
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