require 'spec_helper'

feature "Reviewing (approving/rejecting) Expenses", js: :true, search: true do
  let(:user) { create(:user) }

  scenario "Approving an expense" do
    expense = create(:expense, status: "Pending")
    Sunspot.commit
    visit expenses_path(as: user)
    sleep 1
    expect(page).to have_selector "td", text: "Pending"
    click_link "approve"
    Sunspot.commit
    expect(page).to have_selector "td", text: "Approved"
    expect(expense.reload.status).to eq "Approved"
    # The expense is now approved, so the 'approve' link gets hidden
    expect(page).to_not have_link "approve"
  end

  scenario "Rejecting an expense" do
    expense = create(:expense, status: "Pending")
    Sunspot.commit
    visit expenses_path(as: user)
    sleep 1
    expect(page).to have_selector "td", text: "Pending"
    click_link "reject"
    Sunspot.commit
    expect(page).to have_selector "td", text: "Rejected"
    expect(expense.reload.status).to eq "Rejected"
    # The expense is now rejected, so the 'reject' link gets hidden
    expect(page).to_not have_link "reject"
  end

  scenario "Resetting an expense to Pending" do
    expense = create(:expense, status: "Rejected")
    Sunspot.commit
    visit expenses_path(as: user)
    sleep 1
    expect(page).to have_selector "td", text: "Rejected"
    click_link "pend"
    Sunspot.commit
    expect(page).to have_selector "td", text: "Pending"
    expect(expense.reload.status).to eq "Pending"
    # The expense is now pending, so the 'reject' link gets hidden
    expect(page).to_not have_link "pend"
  end

  scenario "Sorting expenses" do
    user = create(:user)
    early_date = "1999-01-01"
    late_date  = "2000-01-01"
    10.times { create(:expense, user: user, date: early_date) }
    create(:expense, user: user, date: late_date)
    Sunspot.commit
    visit expenses_path(as: user)
    # First sort ascending
    find("td", text: "Date").click
    expect(page).to have_selector "td", text: early_date, count: 10
    # Now sort descending
    find("td", text: "Date").click
    expect(page).to have_selector "td", text: late_date, count: 1
    expect(page).to have_selector "td", text: early_date, count: 9
  end
end
