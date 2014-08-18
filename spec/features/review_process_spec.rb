require 'spec_helper'

feature "Reviewing (approving/rejecting) Expenses", js: :true do
  let(:user) { create(:user) }

  scenario "Approving an expense" do
    expense = create(:expense, status: "Pending")
    visit review_expenses_path(as: user)
    expect(page).to have_selector "td", text: "Pending"
    click_link "approve"
    expect(page).to have_selector "td", text: "Approved"
    expect(expense.reload.status).to eq "Approved"
    # The expense is now approved, so the 'approve' link gets hidden
    expect(page).to_not have_link "approve"
  end

  scenario "Rejecting an expense" do
    expense = create(:expense, status: "Pending")
    visit review_expenses_path(as: user)
    expect(page).to have_selector "td", text: "Pending"
    click_link "reject"
    expect(page).to have_selector "td", text: "Rejected"
    expect(expense.reload.status).to eq "Rejected"
    # The expense is now rejected, so the 'reject' link gets hidden
    expect(page).to_not have_link "reject"
  end

  scenario "Resetting an expense to Pending" do
    expense = create(:expense, status: "Rejected")
    visit review_expenses_path(as: user)
    expect(page).to have_selector "td", text: "Rejected"
    click_link "pend"
    expect(page).to have_selector "td", text: "Pending"
    expect(expense.reload.status).to eq "Pending"
    # The expense is now pending, so the 'reject' link gets hidden
    expect(page).to_not have_link "pend"
  end
end
