def random_date(start_date=10.years.ago.to_date, end_date=1.day.ago.to_date)
  (start_date..end_date).to_a.sample
end
