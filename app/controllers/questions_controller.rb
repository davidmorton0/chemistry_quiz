class QuestionsController < ApplicationController
  
  #admin use
  def index
    if current_user.admin?
      @questions = Question.all
    else
      redirect_to root_path
    end
  end
  
  #admin use
  def show
    if current_user.admin?
      @question = Question.find(params[:id])
    else
      redirect_to root_path
    end
  end

end