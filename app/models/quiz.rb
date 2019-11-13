class Quiz < ApplicationRecord
  has_many :questions, :dependent => :destroy
  belongs_to :user
  validates :title,  presence: true
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :difficulty,  presence: true, numericality: { greater_than: 0, less_than: 11 }
end
