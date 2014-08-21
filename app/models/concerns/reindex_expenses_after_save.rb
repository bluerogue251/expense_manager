module ReindexExpensesAfterSave
  extend ActiveSupport::Concern

  included do
    after_save :reindex_expenses
    around_destroy :reindex_expenses_on_destroy
  end

  private

  def reindex_expenses
    ids = expenses.pluck(:id)
    reindex_in_background(ids)
  end

  def reindex_expenses_on_destroy
    ids = expenses.pluck(:id)
    yield
    reindex_in_background(ids)
  end

  def reindex_in_background(ids)
    ExpenseReindexer.new(ids).delay.reindex
  end

end
