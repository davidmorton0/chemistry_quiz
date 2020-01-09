class ElementQuestion
  include ElementData
  include FakeNames
  
  NAMES = (ELEMENT.map { |s| s[:name] } + FAKENAMES).uniq
  ANSWERS = 4

  def element_question(question_index)
    {
      prompt: "What is the element with the symbol #{ELEMENT[question_index][:symbol]}?",
      correct_answer: ELEMENT[question_index][:name],
      answers: NamesSelector.new(NAMES, ELEMENT[question_index][:name]).answers(ANSWERS, 50)
    }
  end
end