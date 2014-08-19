class ExpensesController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        @expense = Expense.new
      end
      format.json do
        initial_scope = Expense.search { with(:user_id, current_user.id) }
        render json: ExpensesDatatable.new(view_context, initial_scope)
      end
    end
  end

  def review
    respond_to do |format|
      format.html
      format.json do
        render json: ReviewExpensesDatatable.new(view_context, Expense.search)
      end
    end
  end

  def approve
    @expense = Expense.find(params[:id])
    @expense.update!(status: "Approved")
    render "update_status"
  end

  def reject
    @expense = Expense.find(params[:id])
    @expense.update!(status: "Rejected")
    render "update_status"
  end

  def pend
    @expense = Expense.find(params[:id])
    @expense.update!(status: "Pending")
    render "update_status"
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    @expense.save
    render "create_or_update"
  end

  def destroy
    find_expense
    @expense.destroy!
  end

  def edit
    find_expense
  end

  def update
    find_expense
    @expense.update(expense_params)
    render "create_or_update"
  end

  private

  def find_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :category_id, :description, :currency, :amount)
  end

end
