class MolesQuiz
  include ElementData
  
  attr_accessor :quiz, :quiz_type, :num_questions
  
  ELEMENTS = 118
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
      question_info = moles_question(question)
      QuestionMaker.new(question_info, @quiz).make_question
    end
  end
  
  def moles_question(question_index)
    element = ELEMENT[question_index]
    mass = ((0.1 + rand(100) / 10) * element[:ar]).round(2)
    
    correct_answer = (mass / element[:ar]).round(2)

    answers = [ (mass * element[:ar]).round(1).to_s,
              (mass * element[:ar] / 2).round(1).to_s,
              (element[:ar] / mass).round(1).to_s,
              (correct_answer + element[:ar]).to_s ] - [correct_answer.to_s]
    answers = (answers.uniq.take(3) + [correct_answer.to_s]).shuffle
    {
      prompt: "How many moles of atoms are there in #{mass}g of #{ELEMENT[question_index][:name]}?",
      correct_answer: correct_answer.to_s,
      answers: answers
    }
  end
end