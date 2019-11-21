class QuestionsController < ApplicationController
  
  def index
    if current_user.admin?
      @questions = Question.paginate(page: params[:page], per_page: 5)
    else
      redirect_to root_path
    end
  end
  
  def show
    if current_user.admin?
      @question = Question.find(params[:id])
    else
      redirect_to root_path
    end
  end

end