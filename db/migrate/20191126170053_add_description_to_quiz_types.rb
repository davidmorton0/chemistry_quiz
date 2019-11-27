class AddDescriptionToQuizTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_types, :description, :string
  end
end
