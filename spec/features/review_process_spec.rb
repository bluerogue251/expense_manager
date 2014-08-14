require 'spec_helper'

feature "Reviewing (approving/rejecting) Expenses", js: :true do
  let(:user) { create(:user) }

  scenario "Why do we have to use hash notation in view for tests, but not in development" do
    pending
  end

  scenario "Approving an expense" do
    expense = create(:expense, status: "Pending")
    visit review_expenses_path(as: user)
    within "tr#expense_#{expense.id}" do
      expect(page).to have_selector "td.status", text: "Pending"
      click_link "approve"
      expect(page).to have_selector "td.status", text: "Approved"
      expect(expense.reload.status).to eq "Approved"
      # The expense is now approved, so the 'approve' link gets hidden
      expect(page).to_not have_link "approve"
    end
  end

  scenario "Rejecting an expense" do
    expense = create(:expense, status: "Pending")
    visit review_expenses_path(as: user)
    within "tr#expense_#{expense.id}" do
      expect(page).to have_selector "td.status", text: "Pending"
      click_link "reject"
      expect(page).to have_selector "td.status", text: "Rejected"
      expect(expense.reload.status).to eq "Rejected"
      # The expense is now rejected, so the 'reject' link gets hidden
      expect(page).to_not have_link "reject"
    end
  end

  scenario "Resetting an expense to Pending" do
    expense = create(:expense, status: "Rejected")
    visit review_expenses_path(as: user)
    within "tr#expense_#{expense.id}" do
      expect(page).to have_selector "td.status", text: "Rejected"
      click_link "pend"
      expect(page).to have_selector "td.status", text: "Pending"
      expect(expense.reload.status).to eq "Pending"
      # The expense is now pending, so the 'reject' link gets hidden
      expect(page).to_not have_link "pend"
    end
  end
end
