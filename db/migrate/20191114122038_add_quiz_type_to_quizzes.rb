class AddQuizTypeToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_reference :quizzes, :quiz_type, index: true
  end
end
