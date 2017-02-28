class AddPointsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :points, :integer
  end
end
