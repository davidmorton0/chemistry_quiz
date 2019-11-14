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
        @quiz = make_new_quiz(1, user.id)
      end
      redirect_to quiz_path(@quiz.id)
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  def show
    @quiz = Quiz.find(params[:id])
    @quiz_type = QuizType.find(@quiz.quiz_type_id)
  end
  
  def create
    if logged_in?
      user = current_user
      Quiz.find_by(user_id: user)&.destroy
      @quiz = make_new_quiz(1, user.id)
      redirect_to quiz_path(@quiz.id)
    else
      flash[:danger] = 'Log in to do a quiz'
      redirect_to login_path
    end
  end
  
  def update
      #answer questions
    @quiz = Quiz.find(params[:id])
    if params[:submit] == "all"
      @quiz.questions.each do |question|
        answer_question(question, params[:quiz] ? params[:quiz][question.id.to_s] : nil)
      end
    else
      @question = Question.find(params[:submit])
      answer_question(@question, params[:quiz] ? params[:quiz][@question.id.to_s] : nil)
    end
      #update high score if quiz finished
    if  @quiz.questions
          .select{|question| !question.answered}
          .length == 0
        high_score = Score.find_by(quiz_type_id: @quiz.quiz_type_id, user_id: @quiz.user_id)
        if !high_score
          high_score = Score.new(
            score: @quiz.score,
            quiz_type_id: @quiz.quiz_type_id,
            user_id: @quiz.user_id
          )
          high_score.save
          flash[:success] = "New High Score" if @quiz.score > 0
        elsif @quiz.score > high_score.score
          high_score.update(score: @quiz.score)
          flash[:success] = "New High Score"
        end
    end
    
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
    
  end
  
end
