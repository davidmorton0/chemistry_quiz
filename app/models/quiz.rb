class Quiz < ApplicationRecord
  belongs_to :quiz_type
  belongs_to :user
  has_many :questions, :dependent => :destroy
  has_many :answers, through: :questions
  
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :quiz_type_id,  presence: true
  
  def answer(submit, quiz)
    questions.each do |question|
      if submit == "all" || submit == question.id.to_s
        question.answer_question(quiz ? quiz[question.id.to_s] : nil)
      end
    end
    reload
  end
  
  def make_new_quiz(quiz_type, user_id)
    self.update(quiz_type_id: quiz_type.id,
                user_id: user_id,
                score: 0)
    QuizSelector.new(quiz_type, self)
  end
  
  def make_question(question_info)
    question = Question.new(
      prompt: question_info[:prompt],
      correct_answer: question_info[:correct_answer],
      quiz_id: id,
      answered: false )
    question.save
    question.make_answers(question_info[:answers])
  end
  
  def update_high_score()
    HighScoreUpdater.new(self).call.join("\n")
  end
end