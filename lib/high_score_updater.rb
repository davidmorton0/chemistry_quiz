#updates high score and returns message for flash
class HighScoreUpdater
  attr_accessor :quiz, :high_score
  
  def initialize(quiz)
    @quiz = quiz
    @high_score = Score.find_by(
                    quiz_type_id: @quiz.quiz_type.id,
                    user_id: @quiz.user.id)
  end
  
  def call
    message = []
    if @quiz.questions
          .select{|question| !question.answered}
          .length == 0
      
      if !@high_score
        @high_score = Score.create!(
                        score: 0,
                        quiz_type_id: @quiz.quiz_type.id,
                        user_id: @quiz.user.id)
      end
      
      if @quiz.reload.score > @high_score.score
        high_score.update(score: @quiz.score)
        message = ["New High Score!"]
      end
      
      new_time = Time.now - @quiz.created_at
      if @quiz.score == @quiz.quiz_type.num_questions &&
          (!@high_score.fastest_time || new_time < @high_score.fastest_time)
        @high_score.update(fastest_time: new_time)
        message.push("New Fastest Time!")
      end
    end
    return message
  end
end