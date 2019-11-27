class QuizType < ApplicationRecord
  has_many :scores
  validates :name,  presence: true
  validates :num_questions,  presence: true
  validates :difficulty,  presence: true
  validates :level,  presence: true
  validates :description,  presence: true
end