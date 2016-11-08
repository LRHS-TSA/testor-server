class AddStudentTokenAndTeacherTokenToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :student_token, :string
    add_column :groups, :teacher_token, :string
    add_index :groups, :student_token
    add_index :groups, :teacher_token
  end
end
