class QuizzesController < ApplicationController
  include QuestionGenerator

  def show
    if logged_in?
      user = current_user
      @quiz = Quiz.find_by(user_id: user)
      if !@quiz
        @quiz = make_new_quiz(user.id)
      end
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  def create
    if logged_in?
      user = current_user
      Quiz.find_by(user_id: user)&.destroy
      make_new_quiz(user.id)
      redirect_to quiz_path
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
end
