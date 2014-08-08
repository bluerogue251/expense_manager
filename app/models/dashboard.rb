class Dashboard

  def initialize(user)
    @user = user
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
