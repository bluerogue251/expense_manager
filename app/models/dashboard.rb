class Dashboard

  attr_reader :currency

  def initialize(user)
    @user = user
    @currency = user.default_currency
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
    rejected_expenses.sum_in(@currency)
  end

  def pending_total
    pending_expenses.sum_in(@currency)
  end


  private

  def expenses
    @user.expenses
  end

  def rejected_expenses
    expenses.rejected
  end

  def pending_expenses
    expenses.pending
  end

  def approved_expenses
    expenses.approved
  end
end
