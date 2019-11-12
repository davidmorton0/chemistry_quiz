class Question < ApplicationRecord
  has_many :answers, :dependent => :destroy
  belongs_to :quiz
  validates :prompt,  presence: true
  validates :correct_answer,  presence: true
  validates :quiz_id,  presence: true
  validates :answered,  inclusion: [true, false]
end
