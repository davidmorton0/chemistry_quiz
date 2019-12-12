class QuestionsController < ApplicationController
  before_action :admin_user,     only: [:index, :show]
  
  def index
    @questions = Question.paginate(page: params[:page], per_page: 20)
  end
  
  def show
    @question = Question.find(params[:id])
  end
end