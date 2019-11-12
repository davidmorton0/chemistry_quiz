class Quiz < ApplicationRecord
  has_many :questions, :dependent => :destroy
  belongs_to :user
  validates :title,  presence: true
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :num_questions,  presence: true, numericality: { greater_than_or_equal_to: 1}
  validates :user_id,  presence: true
end
