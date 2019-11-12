class Answer < ApplicationRecord
  belongs_to :question
  validates :text,  presence: true
  validates :question,  presence: true
end
