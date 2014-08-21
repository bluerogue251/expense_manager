class ReviewExpensesDatatable
  include DatatablesHelper
  attr_reader :view_context
  delegate :params, :link_to, :fa_icon, :number_with_precision, to: :view_context

  def initialize(view_context)
    @view_context    = view_context
    @display_records = get_records
    # @columns = %w(id date category_id description currency amount status id)
  end

  private

  def total_record_count
    Expense.search.total
  end

  def get_records
    Expense.search do
      fulltext params[:sSearch]
      paginate page: page, per_page: per
    end
  end


  def data
    get_records.results.map do |expense|
      [
        expense.user_name,
        expense.department_name,
        expense.job_title_name,
        expense.date,
        expense.category_name,
        expense.description,
        expense.currency,
        number_with_precision(expense.amount, precision: 2),
        expense.status,
        status_change_links(expense)
      ]
    end
  end

  def status_change_links(expense)
    "#{pend_link(expense)} #{reject_link(expense)} #{approve_link(expense)}"
  end

  def pend_link(expense)
    unless expense.pending?
      link_to fa_icon('step-backward', text: 'pend'), [:pend, expense], method: :patch, remote: true, id: "pend_expense_#{expense.id}", class: "status-link"
    end
  end

  def reject_link(expense)
    unless expense.rejected?
      link_to fa_icon('times', text: 'reject'), [:reject, expense], method: :patch, remote: true, id: "reject_expense_#{expense.id}", class: "reject status-link"
    end
  end

  def approve_link(expense)
    unless expense.approved?
      link_to fa_icon('check', text: 'approve'), [:approve, expense], method: :patch, remote: true, id: "approve_expense_#{expense.id}", class: "approve status-link"
    end
  end
end
