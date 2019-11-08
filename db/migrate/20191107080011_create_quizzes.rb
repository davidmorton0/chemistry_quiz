class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.integer :score
      t.integer :num_questions
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
