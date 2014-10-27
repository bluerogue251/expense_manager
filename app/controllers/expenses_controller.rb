class ExpensesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { @expenses = Datatable.new(params, search_scope, columns) }
    end
  end

  def approve
    change_expense_status("Approved")
  end

  def reject
    change_expense_status("Rejected")
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

  def search_scope
    Sunspot.new_search(Expense)
  end

  def columns
    %i(s_user_name s_department s_job_title s_date s_category_name s_description s_currency s_amount s_status s_user_name s_user_name)
  end
end
