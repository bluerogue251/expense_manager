require "spec_helper"

feature "Expenses" do
  scenario "Indexing only shows the signed-in user's expenses", js: true do
    signed_in_user = create(:user)
    signed_in_users_description = "signed in user's description"
    other_users_description = "other user's description"
    create(:expense, description: signed_in_users_description, user: signed_in_user)
    create(:expense, description: other_users_description)
    visit expenses_path(as: signed_in_user)
    expect(page).to     have_content signed_in_users_description
    expect(page).to_not have_content other_users_description
  end

  scenario "Creating expense auto-assigns it to current_user", js: true do
    user = create(:user)
    create(:category, name: "Test category")
    visit expenses_path(as: user)
    fill_form(:expense, date: "2013-01-01", category: "Test category", description: "Test desc", currency: "CNY", amount: "12.19")
    click_button "Create Expense"
    expect(page).to have_selector "td", text: "Test desc", count: 1
    expect(Expense.count).to eq 1
    expect(Expense.last.user).to eq user
  end

  scenario "Creating expense with invalid data", js: true do
    user = create(:user)
    create(:category, name: "Test category")
    visit expenses_path(as: user)
    fill_form(:expense, date: "not-a-date", category: "Test category", description: "Test desc", currency: "CNY", amount: "12.19")
    click_button "Create Expense"
    expect(page).to have_selector ".error", text: "Date can't be blank"
  end

  scenario "Editing and expense", js: true do
    user = create(:user)
    expense = create(:expense, user: user, description: "Old description")
    visit expenses_path(as: user)
    # saos
    click_link "edit"
    within "form#edit_expense_#{expense.id}" do
      fill_in "expense_description", with: "New description"
    end
    click_button "Update Expense"
    expect(page).to have_selector "td", text: "New description"
    expect(expense.reload.description).to eq "New description"
  end

  scenario "Destroying an expense", js: true do
    user = create(:user)
    description = "test description"
    expense = create(:expense, user: user, description: description)
    visit expenses_path(as: user)
    expect(page).to have_content description
    click_link "destroy_expense_#{expense.id}"
    expect(page).to_not have_content description
    expect(Expense.exists?(expense)).to eq false
  end
end

