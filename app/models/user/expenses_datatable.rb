class User
  class ExpensesDatatable
    include DatatablesHelper

    def initialize(params, user_id)
      @params  = params
      @user_id = user_id
    end

    def total_record_count
      Expense.search { with(:user_id, user_id) }.total
    end

    def data
      get_records.results
    end

    private

    def user_id
      @user_id
    end

    def columns
      %i(s_user_name s_date s_category_name s_description s_currency s_amount s_status s_user_name)
    end

    def get_records
      Expense.search do
        with(:user_id, user_id)
        fulltext params[:sSearch]
        order_by(sort_column, sort_direction)
        paginate page: page, per_page: per
      end
    end
  end
end
