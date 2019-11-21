class QuizzesController < ApplicationController
  
  def index
    if current_user.admin?
      @quizzes = Quiz.paginate(page: params[:page], per_page: 5)
    else
      redirect_to root_path
    end
  end
  
  def show
    if logged_in?
      user = current_user
      @quiz = Quiz.find_by(user_id: user)
      if !@quiz
        redirect_to quiz_types_path
      else
        @score = Score.find_by(user_id: user, quiz_type_id: @quiz.quiz_type)
      end
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  #show any quiz as admin
  def view
    if current_user.admin?
      @quiz = Quiz.find(params[:id])
      render 'show'
    else
      redirect_to root_path
    end
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
    if  @quiz.questions
          .select{|question| !question.answered}
          .length == 0
        @quiz.reload
        flash[:info] = "New High Score!" if @quiz.update_high_score
    end
    
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
    
  end
end
