class ChangeLengthToIntegerInAssignments < ActiveRecord::Migration[5.0]
  def change
    change_column :assignments, :length, :integer
  end
end
