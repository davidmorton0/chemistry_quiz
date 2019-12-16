module ScoresHelper
  def high_score(quiz_type)
    score = Score.where(quiz_type_id: quiz_type.id).order(score: :desc, fastest_time: :asc).first
    if score then
      ["#{score.score} / #{quiz_type.num_questions}",
       format_time(score.fastest_time),
       score.user.name]
    else
      ["-", nil, "-"]
    end
  end
end
