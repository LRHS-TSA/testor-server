class CreateMatchingPairs < ActiveRecord::Migration[5.0]
  def change
    create_table :matching_pairs do |t|
      t.references :question, foreign_key: true
      t.text :item1
      t.text :item2

      t.timestamps
    end
  end
end
