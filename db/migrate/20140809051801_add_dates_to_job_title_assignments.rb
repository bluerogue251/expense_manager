class AddDatesToJobTitleAssignments < ActiveRecord::Migration
  def change
    add_column :job_title_assignments, :starts_on, :date, null: false
    add_column :job_title_assignments, :ends_on, :date, null: false
  end
end
