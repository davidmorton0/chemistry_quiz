class ElementQuiz
  
  ANSWERS = 4
  LEVEL = {
    1 => [0, 1, 2, 5, 6, 7, 8, 9, 10, 11],
    2 => (0..29).to_a,
    3 => (0..ChemData::ELEMENT.length - 1).to_a }

  def self.make_element_quiz(quiz)
    QuestionSelector.select_questions(
      LEVEL[quiz.quiz_type.level],
      quiz.quiz_type.num_questions).each do |q|
        element_question(quiz, q)
    end
  end
  
  def self.element_question(quiz, question_index)
    element = ChemData::ELEMENT[question_index]
    correct_answer = element[:Name]
    
    elements = ChemData::ELEMENT.map { |e| e[:Name] } + ChemData::FAKENAMES - [correct_answer]
    elements_same_letter = elements.select {|e| e.match(element[:Symbol][0]) }
    elements_different_letter = elements - elements_same_letter
    n = [rand(4), elements_same_letter.length].min
    answers = elements_same_letter.shuffle.take(n) + elements_different_letter.shuffle.take(3 - n) + [correct_answer]
    answers.shuffle!
    
    question = Question.new(
      prompt: "What is the element with the symbol #{element[:Symbol]}?",
      correct_answer: correct_answer,
      quiz_id: quiz.id,
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