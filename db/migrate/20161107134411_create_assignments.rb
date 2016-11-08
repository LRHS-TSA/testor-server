class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.string :name
      t.references :group, foreign_key: true
      t.references :test, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.time :length

      t.timestamps
    end
  end
end
