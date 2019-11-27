class AddFastestTimeToScores < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :fastest_time, :integer
  end
end
