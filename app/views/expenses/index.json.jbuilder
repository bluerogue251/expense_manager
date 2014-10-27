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

data = @expenses.data.map do |expense|
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
    status_change_link_two(expense)
  ]
end

json.partial! 'shared/datatables_details', datatable: @expenses, data: data

