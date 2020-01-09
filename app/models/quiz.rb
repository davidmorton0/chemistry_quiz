class Quiz < ApplicationRecord
  belongs_to :quiz_type
  belongs_to :user
  has_many :questions, :dependent => :destroy
  has_many :answers, through: :questions
  
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :quiz_type_id,  presence: true
  
  def answer(answer:, answers:)
    quiz_answerer = QuizAnswerer.new(quiz: self, answers: answers)
    quiz_answerer.fill_answers(answer: answer)
    quiz_answerer.answer_quiz
  end
  
  def update_high_score()
    HighScoreUpdater.new(self).call.join("\n")
  end
  
  def make_new_quiz()
    QuizMaker.new(quiz: self).make_new_quiz
  end
end