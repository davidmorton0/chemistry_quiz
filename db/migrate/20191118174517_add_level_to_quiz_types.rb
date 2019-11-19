class AddLevelToQuizTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_types, :level, :integer
  end
end
