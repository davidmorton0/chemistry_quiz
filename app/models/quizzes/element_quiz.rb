module ElementQuiz
  include ChemData
  
  ELEMENTS = 118
  ANSWERS = 4

  def make_element_quiz(quiz_type, quiz_id)
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
      element_question(quiz_id, questions[x])
    end
  end
  
  def element_question(quiz_id, question_index)
    element = ChemData::Element[question_index]
    correct_answer = element[:Name]
    
    elements = ChemData::Element.map { |e| e[:Name] } + ChemData::FakeElements - [correct_answer]
    elements_same_letter = elements.select {|e| e.match(element[:Symbol][0]) }
    elements_different_letter = elements - elements_same_letter
    n = [rand(4), elements_same_letter.length].min
    answers = elements_same_letter.shuffle.take(n) + elements_different_letter.shuffle.take(3 - n) + [correct_answer]
    answers.shuffle!
    
    question = Question.new(
      prompt: "What is the element with the symbol #{element[:Symbol]}?",
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