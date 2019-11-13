require 'chem_data.rb'

class QuestionsController < ApplicationController
  
  def answer_question(id, answer)
    question = Question.find(id)
    question.update(answered: true, chosen_answer: answer)
    if question.chosen_answer == question.correct_answer then Quiz.increment_counter(:score, question.quiz) end
  end
  
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
    answer_question(params[:id], params[:quiz] ? params[:quiz][params[:id]] : nil)
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
  
  private
    def question_params
      params.require(:question).permit(:prompt, :correct_answer, :quiz, :answered, :chosen_answer)
    end
end
