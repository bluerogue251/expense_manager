def edit_link(expense)
  link_to fa_icon("pencil", text: "edit"), [:edit, :current_user, expense], remote: true, id: "edit_expense_#{expense.id}", class: "edit"
end

def destroy_link(expense)
  link_to fa_icon("times", text: "delete"), [:current_user, expense], method: :delete, remote: true, id: "destroy_expense_#{expense.id}", class: "destroy", data: { confirm: "Delete expense?" }
end

data = @expenses.data.map do |expense|
  [
    edit_link(expense),
    expense.date,
    expense.category_name,
    expense.description,
    expense.currency,
    number_with_precision(expense.amount, precision: 2),
    expense.status,
    destroy_link(expense)
  ]
end

json.partial! 'shared/datatables_details', datatable: @expenses, data: data
