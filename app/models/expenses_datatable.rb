class ExpensesDatatable
  include DatatablesHelper
  attr_reader :view_context
  delegate :params, :link_to, :fa_icon, to: :view_context

  def initialize(view_context, model)
    @scope = model
    @view_context = view_context
    @columns = %w(id date category_id description currency amount status id)
  end

  private

  def data
    paginated_records.map do |expense|
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
