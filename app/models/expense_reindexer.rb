class ExpenseReindexer

  def initialize(expense_ids)
    @expense_ids = expense_ids
  end

  def reindex
    Expense.where(id: @expense_ids).each do |expense|
      expense.index
    end
  end

end
