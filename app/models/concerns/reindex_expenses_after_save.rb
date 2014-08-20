module ReindexExpensesAfterSave
  extend ActiveSupport::Concern

  included do
    after_save :reindex_expenses
    around_destroy :reindex_expenses_on_destroy
  end

  private

  def reindex_expenses
    Sunspot.index!(expenses.reload)
  end

  def reindex_expenses_on_destroy
    ids = expenses.pluck(:id)
    yield
    Sunspot.index!(Expense.where(id: ids))
  end

end
