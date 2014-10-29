module CurrentUser
  class ExpensesController < ApplicationController
    def index
      respond_to do |format|
        format.html
        format.json { @expenses = Datatable.new(params, UserExpenseSearch.new(current_user)) }
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
  end
end
