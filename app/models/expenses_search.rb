class ExpensesSearch
  def search
    Sunspot.new_search(Expense)
  end

  def columns
    %i(s_user_name s_department s_job_title s_date s_category_name s_description s_currency s_amount s_status s_user_name s_user_name)
  end
end
