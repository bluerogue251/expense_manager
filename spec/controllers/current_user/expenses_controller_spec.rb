require 'spec_helper'

describe CurrentUser::ExpensesController do
  it "Scopes expenses through current_user" do
    sign_in
    other_users_expense = create(:expense)
    expect {
      delete :destroy, id: other_users_expense.id
    }.to raise_error ActiveRecord::RecordNotFound
    expect(Expense.exists? other_users_expense).to be_true
  end
end
