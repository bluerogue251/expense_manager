module ReindexExpensesAfterSave
  extend ActiveSupport::Concern

  included do
    after_save :reindex_expenses
    around_destroy :reindex_expenses_on_destroy
  end

  private

  def reindex_expenses
    reindex_in_background(pluck_expense_ids)
  end

  def reindex_expenses_on_destroy
    ids = pluck_expense_ids
    yield
    reindex_in_background(ids)
  end

  def reindex_in_background(ids)
    ExpenseReindexer.new(ids).delay.reindex
  end

  def pluck_expense_ids
    expenses.pluck(:id)
  end

end
