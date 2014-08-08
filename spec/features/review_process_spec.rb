require 'spec_helper'

feature "Reviewing (approving/rejecting) Expenses", js: :true do
  let(:user) { create(:user) }

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

end
