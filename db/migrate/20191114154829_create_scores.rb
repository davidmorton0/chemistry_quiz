class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz_type, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
