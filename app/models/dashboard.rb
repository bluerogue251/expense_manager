class Dashboard
  def initialize(user, date)
    @user = user
    @date = date
  end

  def rejected_count
    rejected_expenses.count
  end

  def pending_count
    pending_expenses.count
  end

  def approved_count
    approved_expenses.count
  end

  def rejected_total
    rejected_expenses.sum_in(currency)
  end

  def pending_total
    pending_expenses.sum_in(currency)
  end

  def approved_total
    expenses.for_month(month).approved.sum_in(currency)
  end

  def month
    year_month(date)
  end

  def previous_month
    date - 1.month
  end

  def next_month
    date + 1.month
  end

  def currency
    user.default_currency
  end

  private
  attr_reader :user, :date

  def expenses
    user.expenses
  end

  def rejected_expenses
    @rejected_expenses ||= expenses.rejected
  end

  def pending_expenses
    @pending_expenses ||= expenses.pending
  end

  def approved_expenses
    @approved_expenses ||= expenses.approved
  end
end
