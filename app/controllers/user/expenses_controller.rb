class User::ExpensesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: ExpensesDatatable.new(view_context, current_user.id)
      end
    end
  end

  def create
    @expense = scope.create(expense_params)
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
    @expense = scope.find(params[:id])
  end

  def scope
    current_user.expenses
  end

  def expense_params
    params.require(:expense).permit(:date, :category_id, :description, :currency, :amount)
  end

end
