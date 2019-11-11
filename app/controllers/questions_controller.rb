require 'chem_data.rb'

class QuestionsController < ApplicationController
  
  #admin use only
  def index
    @questions = Question.all
  end
  
  #admin use only
  def show
    @question = Question.find(params[:id])
  end
  
  #admin use only
  def update
    @question = Question.find(params[:id])
    if params[:answer] && !@question.answered
      @question.update(answered: true, chosen_answer: params[:answer])
      if @question.chosen_answer == @question.correct_answer then Quiz.increment_counter(:score, @question.quiz) end
    end
    redirect_to Quiz.find(@question.quiz_id)
  end
  
  private
    def question_params
      params.require(:question).permit(:prompt, :answer_A, :answer_B, :answer_C, :answer_D, :correct_answer, :quiz, :answered, :chosen_answer)
    end
end
