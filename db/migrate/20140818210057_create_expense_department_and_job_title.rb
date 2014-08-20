class CreateExpenseDepartmentAndJobTitle < ActiveRecord::Migration
  def up
    execute <<-eos
      CREATE VIEW expense_job_title_assignments
      AS
        SELECT
          expenses.id as expense_id,
          job_title_assignments.id as job_title_assignment_id
        FROM expenses
          INNER JOIN job_title_assignments
            ON job_title_assignments.user_id = expenses.user_id
            AND expenses.date BETWEEN job_title_assignments.starts_on AND job_title_assignments.ends_on
    eos
  end

  def down
    execute "DROP VIEW expense_job_title_assignments"
  end
end
