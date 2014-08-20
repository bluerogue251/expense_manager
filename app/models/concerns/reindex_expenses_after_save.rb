module ReindexExpensesAfterSave
  extend ActiveSupport::Concern

  included do
    after_save :reindex_expenses
  end

  private

  def reindex_expenses
    Sunspot.index!(expenses.reload)
  end

end
