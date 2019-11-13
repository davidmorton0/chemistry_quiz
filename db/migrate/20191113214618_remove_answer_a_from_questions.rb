class RemoveAnswerAFromQuestions < ActiveRecord::Migration[6.0]
  def change

    remove_column :questions, :answer_A, :string

    remove_column :questions, :answer_B, :string

    remove_column :questions, :answer_C, :string

    remove_column :questions, :answer_D, :string
  end
end
