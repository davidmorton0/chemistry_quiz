class ScoresController < ApplicationController
  def index
    @quiz_types = QuizType.all.paginate(page: params[:page], per_page: 5)
  end
end
