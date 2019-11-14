class Score < ApplicationRecord
  belongs_to :user
  belongs_to :quiz_type
end
