class QuestionsController < ApplicationController
  before_action :admin_user,     only: [:index, :show]
  
  def index
    if current_user.admin?
      @questions = Question.paginate(page: params[:page], per_page: 5)
    else
      redirect_to root_path
    end
  end
  
  def show
    if current_user.admin?
      @question = Question.find(params[:id])
    else
      redirect_to root_path
    end
  end

  private

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end