require 'chem_data.rb'

class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  def new
    test_elements = 98
    answers = 4
    #select element for question
    q = rand(test_elements - 1)
    possible_answers = [  ChemData::Element[q][:Symbol],    #correct answer
                          ChemData::Element[q][:Name][0],   #first letter of element
                          ChemData::Element[q][:Name][0,2], #first two letters of element
                          ChemData::Element[q][:Name][0] +
                            ChemData::Element[q][:Name][ChemData::Element[q][:Name].length - 1],  #first letter and last letter of element
                          ChemData::Element[q][:Name][0] +
                            ChemData::Element[q][:Name][rand(ChemData::Element[q][:Name].length - 3) + 2],  #first letter and other letter of element
                          ChemData::Element[q][:Name][rand(ChemData::Element[q][:Name].length)].upcase,
                          (65 + rand(26)).chr,              #random letter
                          (65 + rand(26)).chr + (97 + rand(26)).chr ]   #Two random letters
    #add additional answers if less than 4
    while possible_answers.uniq.length < 4
      possible_answers.push((65 + rand(26)).chr + (97 + rand(26)).chr)
    end
    ps = ((possible_answers.uniq - [ChemData::Element[q][:Symbol]]).shuffle.take(answers - 1) + [ChemData::Element[q][:Symbol]]).shuffle
    @question = Question.new(
      prompt: "What is the chemical symbol for #{ChemData::Element[q][:Name]}?",
      answer_A: ps[0], answer_B: ps[1], answer_C: ps[2], answer_D: ps[3],
      correct_answer: ChemData::Element[q][:Symbol], quiz: Quiz.find(0), answered: false
    )
    @question.save
    render 'new'
  end
  
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
