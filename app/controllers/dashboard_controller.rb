class DashboardController < ApplicationController
  delegate :number_with_precision, to: :view_context

  def show
    @dashboard = Dashboard.new(current_user)
    approved_expenses   = current_user.expenses.approved
    @approved_paid      = number_with_precision current_user.payments.sum(:amount), precision: 2
    @approved_total     = number_with_precision approved_expenses.sum(:amount), precision: 2
    @approved_due       = number_with_precision (@approved_total.to_f - @approved_paid.to_f), precision: 2
  end

end
