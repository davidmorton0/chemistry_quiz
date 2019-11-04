class ChemPagesController < ApplicationController
  def home
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def start_quiz
    @question_number = 1
    @page = :question
    @score = 0
    render 'chem_pages/quiz'
  end

  def do_quiz
    @num_questions = 10
    @question_number = params[:quiz][:question_number].to_i
    @score = params[:quiz][:score].to_i
    if params[:quiz][:page] == 'question'
      @page = :answer
      render 'chem_pages/quiz'    
    elsif params[:quiz][:page] == 'answer'
      if @question_number == @num_questions
        render 'chem_pages/result'
      else
        @page = :question
        @question_number += 1
        render 'chem_pages/quiz'
      end
    elsif params[:quiz][:page] == 'result'
      start_quiz
    end
  end
end
