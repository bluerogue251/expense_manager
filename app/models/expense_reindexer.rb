class ExpenseReindexer

  def initialize(expense_ids)
    @expense_ids = expense_ids
  end

  def reindex
    Sunspot.index(expenses)
  end

  private

  def expenses
    Expense.where(id: @expense_ids)
  end

end
