require "spec_helper"

feature "Dashboard" do
  scenario "Navigating to the root path takes you to the Dashboard show page" do
    user = create(:user)
    visit root_path(as: user)
    expect(page).to have_selector "h1", text: "Expenses dashboard"
  end

  scenario "For Rejected expenses, it displays total count" do
    user = create(:user)
    create(:expense, user: user, status: "Rejected")
    visit root_path(as: user)
    expect(page).to have_selector "#rejected-card li.count", text: "1 Expense"
  end

  scenario "For Rejected expenses, it displays total amount in the User's default_currency" do
    user = create(:user, default_currency: "CNY")
    create(:expense, currency: "CNY", amount: 1, user: user, status: "Rejected")
    visit root_path(as: user)
    expect(page).to have_selector "#rejected-card li.total", text: "1.00 CNY"
  end

  scenario "For Pending expenses, it displays total count" do
    user = create(:user)
    create(:expense, user: user, status: "Pending")
    visit root_path(as: user)
    expect(page).to have_selector "#pending-card li.count", text: "1 Expense"
  end

  scenario "For Pending expenses, it displays total amount in the User's default_currency" do
    user = create(:user, default_currency: "CNY")
    create(:expense, currency: "CNY", amount: 1, user: user, status: "Pending")
    visit root_path(as: user)
    expect(page).to have_selector "#pending-card li.total", text: "1.00 CNY"
  end

  scenario "For Approved expenses, it displays total amount from the last month" do
    user = create(:user, default_currency: "CNY")
    create(:expense, user: user, currency: "CNY", status: "Approved", amount: 1, date: "2011-01-01")
    Timecop.travel("2011-02-01") do
      visit root_path(as: user)
      expect(page).to have_selector "#approved-card li.due", text: "1.00 CNY (2011-01)"
    end
  end
end
