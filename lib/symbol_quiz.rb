class SymbolQuiz
  class << self
    ANSWERS = 4
    
    def make_symbol_quiz(quiz)
      question_index = select_questions(quiz.quiz_type.level).shuffle!
      
      (0..quiz.quiz_type.num_questions - 1).each do |x|
        symbol_question(quiz.id, question_index[x])
      end
    end
    
    def select_questions(level)
      if level == 1
        [0, 1, 2, 5, 6, 7, 8, 9, 10, 11]
      elsif level == 2
        (0..29).to_a
      elsif level == 3
        (0..ChemData::ELEMENT.length - 1).to_a
      end
    end
    
    def symbol_question(quiz_id, question_index)
      question = Question.new(
        prompt: "What is the chemical symbol for #{ChemData::ELEMENT[question_index][:Name]}?",
        correct_answer: ChemData::ELEMENT[question_index][:Symbol],
        quiz_id: quiz_id,
        answered: false)
      question.save
      make_wrong_answers( ChemData::ELEMENT[question_index][:Name],
                          ChemData::ELEMENT[question_index][:Symbol],
                          question.id)
      return question
    end
    
    def make_wrong_answers(element_name, correct_answer, question_id)
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
      
      answers = [correct_answer] + (possible_answers.uniq - [correct_answer]).shuffle.take(ANSWERS - 1)
      answers.shuffle!
      
      (0..ANSWERS - 1).each do |a|
        Answer.new( text: answers[a],
                    question_id: question_id).save
      end
    end
  end
end