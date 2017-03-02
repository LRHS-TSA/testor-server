class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.references :session, foreign_key: true
      t.references :question, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end