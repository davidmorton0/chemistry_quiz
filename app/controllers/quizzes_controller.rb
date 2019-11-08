require 'ques_gen.rb'

class QuizzesController < ApplicationController
  include QuesGen
  
  def show
    @quiz = Quiz.find(params[:id])
  end
  
  def index
    user = User.first
    @quiz = Quiz.find_by(user_id: user)
    redirect_to @quiz
  end
  
  def new
    user = User.first
    Quiz.find_by(user_id: user).destroy
    @quiz = Quiz.new
    @quiz.title = "Chemical Symbol Quiz"
    @quiz.num_questions = 10
    @quiz.user_id = user.id
    @quiz.score = 0
    @quiz.save
    (1..@quiz.num_questions).each do
      symbol_question(@quiz.id)
    end
    redirect_to @quiz
  end
  
  def update
    @quiz = Quiz.find(params[:id])
    @quiz.update(quiz_params)
    redirect_to @quiz
  end
  
  private
    def quiz_params
      params.require(:quiz).permit(:title)
    end
end
