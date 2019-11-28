module ScoresHelper
  def high_score(quiz_type)
    score = Score.where(quiz_type_id: quiz_type.id).order(score: :desc, fastest_time: :asc).first
    score_info = []
    if score then
      score_info.push("#{score.score} / #{quiz_type.num_questions}")
      score_info.push(format_time(score.fastest_time))
      score_info.push(score.user.name)
    else
      score_info.push("-")
      score_info.push(nil)
      score_info.push("-")
    end
  end
end
