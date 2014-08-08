require 'spec_helper'

feature "Reviewing (approving/rejecting) Expenses", js: :true do
  let(:user) { create(:user) }
  scenario "Approving an expense" do
    expense = create(:expense, status: "Pending")
    visit review_expenses_path(as: user)
    within "tr#expense_#{expense.id}" do
      expect(page).to have_selector "td.status", text: "Pending"
      click_link "approve"
      # The expense is now approved, so the 'approve' link gets hidden
      expect(page).to have_selector "td.status", text: "Approved"
      expect(page).to_not have_link "approve"
    end
  end
end
