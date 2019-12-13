class QuizTypesController < ApplicationController
  before_action :logged_in_user, only: [:show]
  
  def index
    @quiz_types = QuizType.paginate(page: params[:page], per_page: 5)
  end

  def show
    current_user.quiz&.destroy
    QuizMaker.new(
      current_user.id,
      params[:id].to_i).make_new_quiz
    redirect_to quiz_path
  end
end
