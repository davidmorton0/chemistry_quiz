class CreateQuizTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_types do |t|
      t.string :name
      t.integer :num_questions
      t.integer :difficulty

      t.timestamps
    end
  end
end
