class CreateMultipleChoiceOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :multiple_choice_options do |t|
      t.references :question, foreign_key: true
      t.text :text
      t.boolean :correct

      t.timestamps
    end
  end
end
