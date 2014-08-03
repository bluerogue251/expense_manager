class ExpensesController < ApplicationController

  def index
    @expenses = current_user.expenses
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.save
  end

  def destroy
    find_expense
    @expense.destroy!
  end

  private

  def find_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :category_id, :description, :currency, :amount)
  end

end
