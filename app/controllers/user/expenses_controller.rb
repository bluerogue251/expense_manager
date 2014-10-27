class User::ExpensesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { @expenses = Datatable.new(params, search_scope, columns) }
    end
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

  def search_scope
    Sunspot.new_search(Expense) { with(:user_id, current_user.id) }
  end

  def columns
    %i(s_user_name s_date s_category_name s_description s_currency s_amount s_status s_user_name)
  end
end
