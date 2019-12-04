class QuizzesController < ApplicationController
  before_action :admin_user, only: [:index, :view]
  
  def index
    @quizzes = Quiz.paginate(page: params[:page], per_page: 5)
  end
  
  #show quiz as user
  def show
    if logged_in?
      @quiz = Quiz.find_by(user_id: current_user)
      if !@quiz
        redirect_to quiz_types_path
      end
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
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
    @quiz.answer(params[:submit], params[:quiz])
    
    message = @quiz.update_high_score
    
    if !message.empty?
      flash[:info] = message
    end
    
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
  
  private
  
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user && current_user.admin?
    end
end
