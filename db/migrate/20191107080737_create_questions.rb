class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :prompt
      t.string :answer_A
      t.string :answer_B
      t.string :answer_C
      t.string :answer_D
      t.string :correct_answer
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
