class AddExchangeRateDateRangeConstraint < ActiveRecord::Migration
  def up
    execute <<-eos

      CREATE FUNCTION unique_exchange_rate_date_range(record_id integer,
                                                      new_anchor text,
                                                      new_float text,
                                                      new_start_date date,
                                                      new_end_date date)
        RETURNS boolean AS $$
          BEGIN
            IF (SELECT count(*) FROM exchange_rates
                WHERE new_anchor = anchor
                AND new_float = float
                AND record_id != id
                AND daterange(new_start_date, new_end_date) && daterange(starts_on, ends_on)
               ) = 0 THEN RETURN TRUE;
            ELSE
              RETURN FALSE;
            END IF;
          END;
          $$ LANGUAGE plpgsql;

      alter table exchange_rates
      add constraint unique_date_ranges
      check (unique_exchange_rate_date_range(id,
                                             anchor,
                                             float,
                                             starts_on,
                                             ends_on));

    eos
  end

  def down
    execute <<-eos
      alter table exchange_rates drop constraint unique_date_ranges;
      drop function unique_exchange_rate_date_range(integer, text, text, date, date);
    eos
  end
end
