class QuizzesController < ApplicationController
  
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
        flash[:success] = "New High Score" if @quiz.update_high_score
    end
    
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
    
  end
end
