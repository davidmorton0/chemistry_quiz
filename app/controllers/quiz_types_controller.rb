class QuizTypesController < ApplicationController
  def index
    @quiztypes = QuizType.all
  end
  
  def show
    if logged_in?
      @quiz_type = QuizType.find(params[:id])
      user = current_user
      Quiz.find_by(user_id: user)&.destroy
      @quiz = make_new_quiz(@quiz_type, user.id)
      redirect_to quiz_path(@quiz.id)
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
end
