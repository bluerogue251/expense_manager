class CreateExpenseDepartmentAndJobTitle < ActiveRecord::Migration
  def up
    execute <<-eos
      CREATE VIEW expense_department_and_job_titles
      AS
        SELECT
          expenses.id as expense_id,
          departments.name as department_name,
          job_titles.name as job_title_name
        FROM expenses
          INNER JOIN job_title_assignments jta
            ON jta.user_id = expenses.user_id
            AND expenses.date BETWEEN jta.starts_on AND jta.ends_on
          INNER JOIN job_titles
              ON jta.job_title_id = job_titles.id
          INNER JOIN departments
              ON jta.department_id = departments.id
    eos
  end

  def down
    execute <<-eos
      DROP VIEW expense_department_and_job_titles
    eos
  end
end
