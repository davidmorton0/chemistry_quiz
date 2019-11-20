class QuestionsController < ApplicationController
  
  #admin use
  def index
    @questions = Question.all
  end
  
  #admin use
  def show
    @question = Question.find(params[:id])
  end
  
  private
    def question_params
      params.require(:question).permit(:prompt, :correct_answer, :quiz, :answered, :chosen_answer)
    end
end