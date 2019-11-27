ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  fixtures :all
  include ApplicationHelper
  
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # Log in as a particular user.
  def log_in_as(user)
    session[:user_id] = user.id
  end
  
  def base_title
    " | Chemistry Quiz"
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
  
  def answer_all_questions_correctly(quiz)
    answers = {}
    quiz.questions.map{ |question| 
      answers[question.id.to_s] = question.correct_answer
    }
    patch quiz_path, params: {
      "_method"=>"patch",
      "submit"=>"all",
      "quiz"=>answers,
      "commit"=>"Answer All",
      "controller"=>"quizzes",
      "action"=>"update",
      "id"=>quiz.id}, xhr: true
  end
  
  def answer_all_questions_incorrectly(quiz)
    patch quiz_path, params: {
      "_method"=>"patch",
      "submit"=>"all",
      "commit"=>"Answer All",
      "controller"=>"quizzes",
      "action"=>"update",
      "id"=>@quiz.id}, xhr: true
  end
end
