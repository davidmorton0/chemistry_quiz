class Quiz < ApplicationRecord
  belongs_to :quiz_type
  belongs_to :user
  has_many :questions, :dependent => :destroy
  has_many :answers, through: :questions
  
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :quiz_type_id,  presence: true
  
  def answer(answers)
    QuizAnswerer.new.answer_quiz(self, answers)
  end
  
  def update_high_score()
    HighScoreUpdater.new(self).call.join("\n")
  end
end