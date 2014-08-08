class DashboardController < ApplicationController
  delegate :number_with_precision, to: :view_context

  def show
    @dashboard = Dashboard.new(current_user)
    expenses            = current_user.expenses
    rejected_expenses   = expenses.rejected
    @rejected_total     = number_with_precision rejected_expenses.sum(:amount), precision: 2
    pending_expenses    = expenses.pending
    @pending_total      = number_with_precision pending_expenses.sum(:amount), precision: 2
    approved_expenses   = expenses.approved
    @approved_paid      = number_with_precision current_user.payments.sum(:amount), precision: 2
    @approved_total     = number_with_precision approved_expenses.sum(:amount), precision: 2
    @approved_due       = number_with_precision (@approved_total.to_f - @approved_paid.to_f), precision: 2
  end

end
