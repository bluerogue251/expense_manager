class ReviewExpensesDatatable
  include DatatablesHelper
  attr_reader :view_context
  delegate :params, :link_to, :fa_icon, :number_with_precision, to: :view_context

  def initialize(view_context)
    @view_context    = view_context
    @display_records = get_records
  end

  private

  def columns
    %w(s_user_name s_department_name s_job_title_name s_date s_category_name s_description s_currency s_amount s_status s_user_name s_user_name)
  end

  def total_record_count
    Expense.search.total
  end

  def get_records
    c = sort_column
    d = sort_direction
    Expense.search do
      fulltext params[:sSearch]
      order_by(c, d)
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
        status_change_link_one(expense),
        status_change_link_two(expense),
      ]
    end
  end

  def status_change_link_one(expense)
    expense.rejected? ? pend_link(expense) : reject_link(expense)
  end

  def status_change_link_two(expense)
    expense.approved? ? pend_link(expense) : approve_link(expense)
  end

  def status_change_link(expense, type, icon)
    link_to fa_icon(icon, text: type),
            [type, expense],
            method: :patch,
            remote: true,
            id: "#{type}_expense_#{expense.id}",
            class: "status-link #{type}",
            data: { confirm: "#{type} expense?" }
  end

  def pend_link(expense)
    status_change_link(expense, :pend, "step-backward")
  end

  def reject_link(expense)
    status_change_link(expense, :reject, "times")
  end

  def approve_link(expense)
    status_change_link(expense, :approve, "check")
  end
end
