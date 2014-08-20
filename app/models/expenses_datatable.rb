class ExpensesDatatable
  include DatatablesHelper
  attr_reader :view_context
  delegate :params, :link_to, :fa_icon, to: :view_context

  def initialize(view_context, current_user_id)
    @view_context    = view_context
    @current_user_id = current_user_id
    @display_records = get_records
  end

  private

  def columns
    %i(s_user_name s_date s_category_name s_description s_currency s_amount s_status s_user_name)
  end

  def current_user_id
    @current_user_id
  end

  def total_record_count
    Expense.search { with(:user_id, current_user_id) }.total
  end

  def get_records
    c = sort_column
    d = sort_direction
    Expense.search do
      with(:user_id, current_user_id)
      fulltext params[:sSearch]
      order_by(c, d)
      paginate page: page, per_page: per
    end
  end

  def data
    @display_records.results.map do |expense|
      [
        edit_link(expense),
        expense.date,
        expense.category_name,
        expense.description,
        expense.currency,
        expense.amount,
        expense.status,
        destroy_link(expense)
      ]
    end
  end

  def edit_link(expense)
    link_to fa_icon('pencil', text: 'edit'), [:edit, expense], remote: true, id: "edit_expense_#{expense.id}", class: "edit"
  end

  def destroy_link(expense)
    link_to fa_icon('times', text: 'delete'), expense, method: :delete, remote: true, id: "destroy_expense_#{expense.id}", class: "destroy", data: { confirm: "Delete expense?" }
  end
end
