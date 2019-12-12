class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, :dependent => :destroy
  has_one :quiz_type, through: :quiz
  has_one :user, through: :quiz
  
  validates :prompt,  presence: true
  validates :correct_answer,  presence: true
  validates :quiz_id,  presence: true
  validates :answered,  inclusion: [true, false]
  
  def answer_question(answer)
    if !self.answered
      self.update(answered: true, chosen_answer: answer)
      Quiz.increment_counter(:score, self.quiz.id) if self.chosen_answer == self.correct_answer
    end
  end
  
end
