require "spec_helper"

feature "Expenses", js: true, search: true do
  scenario "Indexing only shows the signed-in user's expenses" do
    signed_in_user = create(:user)
    signed_in_users_description = "signed in user's description"
    other_users_description = "other user's description"
    create(:expense, description: signed_in_users_description, user: signed_in_user)
    create(:expense, description: other_users_description)
    Sunspot.commit
    visit current_user_expenses_path(as: signed_in_user)
    expect(page).to     have_content signed_in_users_description
    expect(page).to_not have_content other_users_description
  end

  scenario "Creating expense auto-assigns it to current_user" do
    user = create(:user)
    create(:category, name: "Test category")
    visit current_user_expenses_path(as: user)
    fast_fill_form(:expense, date: "2013-01-01", category: "Test category", description: "Test desc", currency: "CNY", amount: "12.19")
    click_button "Create Expense"
    Sunspot.commit
    expect(page).to have_selector "td", text: "Test desc", count: 1
    expect(Expense.count).to eq 1
    expect(Expense.last.user).to eq user
  end

  scenario "Creating expense with invalid data" do
    user = create(:user)
    create(:category, name: "Test category")
    visit current_user_expenses_path(as: user)
    fast_fill_form(:expense, date: "not-a-date", category: "Test category", description: "Test desc", currency: "CNY", amount: "12.19")
    click_button "Create Expense"
    Sunspot.commit
    expect(page).to have_selector ".error", text: "Date can't be blank"
  end

  scenario "Editing an expense" do
    user = create(:user)
    expense = create(:expense, user: user, description: "Old description")
    Sunspot.commit
    visit current_user_expenses_path(as: user)
    click_link "edit"
    within "form#edit_expense_#{expense.id}" do
      fill_in "expense_description", with: "New description"
    end
    click_button "Update Expense"
    Sunspot.commit
    expect(page).to have_selector "td", text: "New description"
    expect(expense.reload.description).to eq "New description"
  end

  scenario "Destroying an expense" do
    user = create(:user)
    description = "test description"
    expense = create(:expense, user: user, description: description)
    Sunspot.commit
    visit current_user_expenses_path(as: user)
    expect(page).to have_content description
    click_link "destroy_expense_#{expense.id}"
    Sunspot.commit
    expect(page).to_not have_content description
    expect(Expense.exists?(expense)).to eq false
  end

  scenario "Sorting expenses" do
    user = create(:user)
    a_desc = "aaa description"
    z_desc = "zzz description"
    10.times { create(:expense, user: user, description: a_desc) }
    create(:expense, user: user, description: z_desc)
    Sunspot.commit
    visit current_user_expenses_path(as: user)
    # First sort ascending
    find("td", text: "Description").click
    expect(page).to have_selector "td", text: a_desc, count: 10
    # Now sort descending
    find("td", text: "Description").click
    expect(page).to have_selector "td", text: z_desc, count: 1
    expect(page).to have_selector "td", text: a_desc, count: 9
  end
end
