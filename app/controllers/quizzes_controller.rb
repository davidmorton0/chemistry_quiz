require 'ques_gen.rb'

class QuizzesController < ApplicationController
  include QuesGen

  def show
    user = User.first
    @quiz = Quiz.find_by(user_id: user)
    #if !@quiz then new end
  end
  
  def new
    user = User.first         #needs to select current user in final version

    Quiz.find_by(user_id: user)&.destroy
    @quiz = Quiz.new
    @quiz.title = "Chemical Symbol Quiz"
    @quiz.num_questions = 10
    @quiz.user_id = user.id
    @quiz.score = 0
    @quiz.save
    (1..@quiz.num_questions).each do
      symbol_question(@quiz.id)
    end
    render 'show'
  end
  
end
