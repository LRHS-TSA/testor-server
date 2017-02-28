class CreateMultipleChoiceAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :multiple_choice_answers do |t|
      t.references :question, foreign_key: true
      t.references :session, foreign_key: true
      t.references :multiple_choice_option, foreign_key: true

      t.timestamps
    end
  end
end
