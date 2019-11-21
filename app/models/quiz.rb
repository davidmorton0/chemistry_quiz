require './app/models/quizzes/symbol_quiz.rb'
require './app/models/quizzes/element_quiz.rb'

class Quiz < ApplicationRecord
  include SymbolQuiz
  include ElementQuiz
  
  has_many :questions, :dependent => :destroy
  has_many :answers, through: :questions
  has_one :user
  belongs_to :quiz_type
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :quiz_type_id,  presence: true
  
  def make_new_quiz(quiz_type, user_id)
    self.quiz_type_id = quiz_type.id
    self.user_id = user_id
    self.score = 0
    self.save
    
    if quiz_type.name == "Chemical Symbol Quiz"
      self.make_symbol_quiz(quiz_type, self.id)
    elsif quiz_type.name == "Chemical Element Quiz"
      self.make_element_quiz(quiz_type, self.id)
    end
  end
  
  def update_high_score()
    high_score = Score.find_by(quiz_type_id: quiz_type_id, user_id: user_id)
    if !high_score
      high_score = Score.new(
        score: score,
        quiz_type_id: quiz_type_id,
        user_id: user_id
      )
      high_score.save
      return score > 0 ? true : false
    elsif score > high_score.score
      high_score.update(score: score)
      return true
    else
      return false
    end
  end
end