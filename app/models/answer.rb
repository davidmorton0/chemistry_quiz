class Answer < ApplicationRecord
  belongs_to :question
  has_one :quiz, through: :question
  validates :text,  presence: true
  validates :question,  presence: true
end
