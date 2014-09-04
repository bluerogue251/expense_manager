class ExpensesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: ExpensesDatatable.new(view_context)
      end
    end
  end

  def approve
    change_expense_status("Pending")
  end

  def reject
    change_expense_status("Pending")
  end

  def pend
    change_expense_status("Pending")
  end

  private

  def find_expense
    @expense = Expense.find(params[:id])
  end

  def change_expense_status(new_status)
    find_expense
    @expense.update!(status: new_status)
    render "update_status"
  end

end
