class Score < ApplicationRecord
  belongs_to :user
  belongs_to :quiz_type
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :quiz_type_id,  presence: true
end
