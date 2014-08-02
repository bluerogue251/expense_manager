class CreateJobTitleAssignments < ActiveRecord::Migration
  def change
    create_table :job_title_assignments do |t|
      t.integer :user_id, null: false
      t.integer :job_title_id, null: false
      t.integer :department_id, null: false
      t.timestamps null: false
    end
  end
end
