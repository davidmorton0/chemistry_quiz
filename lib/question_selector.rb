class QuestionSelector
  def self.select_questions(questions, num_questions)
    questions.shuffle.take(num_questions)
  end
end