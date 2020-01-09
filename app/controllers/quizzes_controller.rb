class QuizzesController < ApplicationController
  before_action :admin_user, only: [:index, :view]
  before_action :logged_in_user, only: [:show, :update]
  
  def index
    @quizzes = Quiz.paginate(page: params[:page], per_page: 10)
  end
  
  #show quiz as user
  def show
    @quiz = Quiz.find_by(user_id: current_user)
    if !@quiz
      redirect_to quiz_types_path
    end
  end
  
  #view any quiz as admin
  def view
    @quiz = Quiz.find(params[:id])
    render 'show'
  end
  
  def update
    #answer questions
    @quiz = current_user.quiz
    @quiz.answer(answer: params[:submit], answers: params[:quiz])
    message = @quiz.update_high_score

    if !message.empty?
      flash[:info] = message
    end
    
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
end
