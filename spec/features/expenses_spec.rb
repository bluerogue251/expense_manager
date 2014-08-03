require "spec_helper"

feature "Expenses" do
  scenario "Indexing only shows the signed-in user's expenses" do
    signed_in_user         = create(:user)
    signed_in_user_expense = create(:expense, user: signed_in_user)
    other_user_expense     = create(:expense)
    visit expenses_path(as: signed_in_user)
    expect(page).to     have_selector "tr#expense_#{signed_in_user_expense.id}"
    expect(page).to_not have_selector "tr#expense_#{other_user_expense.id}"
  end

  scenario "Destroying an expense", js: true do
    user = create(:user)
    expense = create(:expense, user: user)
    visit expenses_path(as: user)
    expect(page).to have_selector "tr#expense_#{expense.id}"
    click_link "destroy_expense_#{expense.id}"
    expect(page).to_not have_selector "tr#expense_#{expense.id}"
    expect(Expense.exists?(expense)).to eq false
  end
end

