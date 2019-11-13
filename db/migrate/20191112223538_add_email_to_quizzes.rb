class AddEmailToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :difficulty, :integer
  end
end
