class UserExpenseSearch
  def initialize(current_user)
    @current_user = current_user
  end

  def search
    Sunspot.new_search(Expense) do
      with(:user_id, current_user.id)
    end
  end

  def columns
    %i(s_user_name s_date s_category_name s_description s_currency s_amount s_status s_user_name)
  end

  private

  attr_reader :current_user
end
