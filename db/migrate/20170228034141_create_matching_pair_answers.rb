class CreateMatchingPairAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :matching_pair_answers do |t|
      t.references :question, foreign_key: true
      t.references :session, foreign_key: true
      t.string :item1
      t.string :item2

      t.timestamps
    end
  end
end
