class ExpensesDatatable
  include DatatablesHelper

  def initialize(params)
    @params = params
  end

  def total_record_count
    Expense.search.total
  end

  def data
    get_records.results
  end

  private

  def columns
    %w(s_user_name s_department_name s_job_title_name s_date s_category_name s_description s_currency s_amount s_status s_user_name s_user_name)
  end

  def get_records
    Expense.search do
      fulltext params[:sSearch]
      order_by(sort_column, sort_direction)
      paginate page: page, per_page: per
    end
  end
end
