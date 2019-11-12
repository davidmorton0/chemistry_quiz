require 'chem_data.rb'

class QuestionsController < ApplicationController
  
  #admin use
  def index
    @questions = Question.all
  end
  
  #admin use
  def show
    @question = Question.find(params[:id])
  end
  
  # answers a question
  def update
    @question = Question.find(params[:id])
    @question.update(answered: true, chosen_answer: params[:answer])
    if @question.chosen_answer == @question.correct_answer then Quiz.increment_counter(:score, @question.quiz) end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
  
  private
    def question_params
      params.require(:question).permit(:prompt, :answer_A, :answer_B, :answer_C, :answer_D, :correct_answer, :quiz, :answered, :chosen_answer)
    end
end
