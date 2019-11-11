class Question < ApplicationRecord
  belongs_to :quiz
  validates :prompt,  presence: true
  validates :answer_A,  presence: true
  validates :answer_B,  presence: true
  validates :answer_C,  presence: true
  validates :answer_D,  presence: true
  validates :correct_answer,  presence: true
  validates :quiz_id,  presence: true
  validates :answered,  inclusion: [true, false]
end
