class QuizzesController < ApplicationController
  include QuestionGenerator
  
  def answer_question(question, answer)
    if !question.answered
      question.update(answered: true, chosen_answer: answer)
      Quiz.increment_counter(:score, question.quiz) if question.chosen_answer == question.correct_answer
    end
  end
  
  def index
    if logged_in?
      user = current_user
      @quiz = Quiz.find_by(user_id: user)
      if !@quiz
        @quiz = make_new_quiz(user.id)
      end
      redirect_to quiz_path(@quiz.id)
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  def show
    @quiz = Quiz.find(params[:id])
  end
  
  def create
    if logged_in?
      user = current_user
      Quiz.find_by(user_id: user)&.destroy
      @quiz = make_new_quiz(user.id)
      redirect_to quiz_path(@quiz.id)
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  def update
    if params[:submit] == "all"
      @quiz = Quiz.find(params[:id])
      @quiz.questions.each do |question|
        answer_question(question, params[:quiz] ? params[:quiz][question.id.to_s] : nil)
      end
    else
      @question = Question.find(params[:submit])
      answer_question(@question, params[:quiz] ? params[:quiz][@question.id.to_s] : nil)
    end
    
    respond_to do |format|
      format.js {render inline: "window.location.reload(true);" }
    end
  end
  
end
