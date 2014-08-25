class AddDateRangeConstraintToJobTitleAssignments < ActiveRecord::Migration
  def up
    execute <<-eos

      CREATE FUNCTION unique_job_title_assignment_date_range(record_id integer,
                                                             new_user_id integer,
                                                             new_start_date date,
                                                             new_end_date date)
        RETURNS boolean AS $$
          BEGIN
            IF
               (
                 SELECT 1 FROM job_title_assignments
                 WHERE user_id = new_user_id
                 AND record_id != id
                 AND new_start_date BETWEEN starts_on AND ends_on
                 LIMIT 1
               ) IS NULL

               AND

               (
                 SELECT 1 FROM job_title_assignments
                 WHERE user_id = new_user_id
                 AND record_id != id
                 AND new_end_date BETWEEN starts_on AND ends_on
                 LIMIT 1
               ) IS NULL THEN
              RETURN TRUE;
            ELSE
              RETURN FALSE;
            END IF;
          END;
          $$ LANGUAGE plpgsql;

      alter table job_title_assignments
      add constraint unique_date_ranges
      check (unique_job_title_assignment_date_range(id,
                                                    user_id,
                                                    starts_on,
                                                    ends_on));

    eos
  end

  def down
    execute <<-eos
      alter table job_title_assignments drop constraint unique_date_ranges;
      drop function unique_job_title_assignment_date_range(integer, date, date);
    eos
  end
end
