class RemoveFieldNameFromQuiz < ActiveRecord::Migration[6.0]
  def change

    remove_column :quizzes, :num_questions, :integer
  end
end
