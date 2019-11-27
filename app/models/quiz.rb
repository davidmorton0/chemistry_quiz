class Quiz < ApplicationRecord
  include ChemData
  include SymbolQuiz
  include ElementQuiz
  include SubstanceQuiz
  
  belongs_to :quiz_type
  belongs_to :user
  has_many :questions, :dependent => :destroy
  has_many :answers, through: :questions
  
  validates :score,  presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :user_id,  presence: true
  validates :quiz_type_id,  presence: true
  
  def make_new_quiz(quiz_type, user_id)
    self.quiz_type_id = quiz_type.id
    self.user_id = user_id
    self.score = 0
    self.save
    
    if quiz_type.name == "Chemical Symbol Quiz"
      self.make_symbol_quiz(quiz_type, self.id)
    elsif quiz_type.name == "Chemical Element Quiz"
      self.make_element_quiz(quiz_type, self.id)
    elsif quiz_type.name == "Substance Properties Quiz"
      self.make_substance_quiz(quiz_type, self.id)
    end
  end
  
  def update_high_score()
    high_score = Score.find_by(quiz_type_id: quiz_type_id, user_id: user_id)
    if !high_score
      high_score = Score.create!(
        score: score,
        quiz_type_id: quiz_type_id,
        user_id: user_id
      )
      new_high_score = score > 0 ? true : false
    elsif score > high_score.score
      high_score.update(score: score)
      new_high_score = true
    else
      new_high_score = false
    end
    new_time = Time.now - created_at
    if score == quiz_type.num_questions && (new_high_score || new_time < high_score.fastest_time)
      high_score.update(fastest_time: new_time)
      new_fastest_time = true
    else
      new_fastest_time = false
    end
    return [new_high_score, new_fastest_time]
  end
end