class QuizType < ApplicationRecord
  has_many :scores
  validates :name,  presence: true
  validates :num_questions,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :difficulty,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :level,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :description,  presence: true
end