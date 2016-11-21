class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :test, foreign_key: true
      t.text :text
      t.integer :question_type

      t.timestamps
    end
  end
end
