class CreateTextAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :text_answers do |t|
      t.references :question, foreign_key: true
      t.references :session, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
