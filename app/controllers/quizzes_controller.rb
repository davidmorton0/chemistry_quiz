class QuizzesController < ApplicationController
  before_action :admin_user, only: [:index, :view]
  
  def index
    @quizzes = Quiz.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    if logged_in?
      user = current_user
      @quiz = Quiz.find_by(user_id: user)
      if !@quiz
        redirect_to quiz_types_path
      else
        @score = Score.find_by(user_id: user, quiz_type_id: @quiz.quiz_type)
        @quiz_types = QuizType.where(name: @quiz.quiz_type.name)
      end
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  #show any quiz as admin
  def view
    @quiz = Quiz.find(params[:id])
    @quiz_types = QuizType.where(name: @quiz.quiz_type.name)
    render 'show'
  end
  
  def update
    
    #answer questions
    @quiz = current_user.quiz
    if params[:submit] == "all"
      @quiz.questions.each do |question|
        question.answer_question(params[:quiz] ? params[:quiz][question.id.to_s] : nil)
      end
    else
      Question
        .find(params[:submit])
        .answer_question(params[:quiz] ? params[:quiz][params[:submit]] : nil)
    end
    
    #update high score if quiz finished
    if @quiz.questions
          .select{|question| !question.answered}
          .length == 0
        @quiz.reload
        new_scores = @quiz.update_high_score
        message = []
        message.push("New High Score!") if new_scores[0]
        message.push("New Fastest Time!") if new_scores[1]
        if !message.empty?
          flash[:info] = message.join("\n")
        end
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
