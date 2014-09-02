class Api::V1::ExpensesController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.expenses.limit(10)
  end

  def review
    render json: ReviewExpensesDatatable.new(view_context)
  end

  def approve
    respond_with unscoped_expense.update(status: "Approved")
  end

  def reject
    respond_with unscoped_expense.update(status: "Rejected")
  end

  def pend
    respond_with unscoped_expense.update(status: "Pending")
  end

  def create
    respond_with current_user.expenses.create(expense_params)
    respond_with @expense.save
  end

  def destroy
    respond_with find_expense.destroy
  end

  def edit
    respond_with find_expense
  end

  def update
    respond_with find_expense.update(expense_params)
  end

  private

  def find_expense
    current_user.expenses.find(params[:id])
  end

  def unscoped_expense
    Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :category_id, :description, :currency, :amount)
  end

end
