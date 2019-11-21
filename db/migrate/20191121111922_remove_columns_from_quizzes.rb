class RemoveColumnsFromQuizzes < ActiveRecord::Migration[6.0]
  def change

    remove_column :quizzes, :difficulty, :integer

    remove_column :quizzes, :title, :string
  end
end
