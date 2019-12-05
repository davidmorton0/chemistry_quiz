module MolesQuiz
  
  ELEMENTS = 118
  ANSWERS = 4
  
  def self.make_moles_quiz(quiz_type, quiz_id)
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
      moles_question(quiz_id, questions[x])
    end
  end
  
  def self.moles_question(quiz_id, question_index)
    element = ChemData::ELEMENT[question_index]
    correct_answer = (rand() * 10).round(1)
    mass = (correct_answer * element[:Ar]).round(1)

    answers = []
    answers.push(correct_answer)
    answers.push((mass * element[:Ar]).round(1))
    answers.push((mass * element[:Ar] / 2).round(1))
    answers.push((element[:Ar] / mass).round(1))
    
    answers.shuffle!
    
    question = Question.new(
      prompt: "How many moles of atoms are there in #{mass}g of #{element[:Name]}?",
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