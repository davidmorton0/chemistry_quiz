class AddChosenAnswerToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :chosen_answer, :string
  end
end
