class ElementQuiz
  include ElementData
  include FakeNames
  
  attr_accessor :quiz, :quiz_type, :num_questions
  
  NAMES = (ELEMENT.map { |s| s[:name] } + FAKENAMES).uniq
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
      question_info = element_question(question)
      QuestionMaker.new(question_info, @quiz).make_question
    end
  end

  def element_question(question_index)
    {
      prompt: "What is the element with the symbol #{ELEMENT[question_index][:symbol]}?",
      correct_answer: ELEMENT[question_index][:name],
      answers: NamesSelector.new(NAMES, ELEMENT[question_index][:name]).answers(ANSWERS, 50)
    }
  end
end