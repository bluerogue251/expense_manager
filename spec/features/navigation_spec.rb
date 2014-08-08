require 'spec_helper'

feature "Navigation" do
  scenario "Clicking the Dashboard link navigates to the dashboard (home page)" do
    user = create(:user)
    visit expenses_path(as: user)
    click_link "Dashboard"
    expect(current_path).to eq root_path
  end

  scenario "Clicking the Expenses link navigates to the expense index page" do
    user = create(:user)
    visit root_path(as: user)
    click_link "Expenses"
    expect(current_path).to eq expenses_path
  end

  scenario "Clicking the Profile link navigates to the profile page" do
    user = create(:user)
    visit root_path(as: user)
    click_link "Profile"
    expect(current_path).to eq edit_user_path(user)
  end

  scenario "Clicking the Review link navigates to the expense review page" do
    user = create(:user)
    visit root_path(as: user)
    click_link "Review"
    expect(current_path).to eq review_expenses_path
  end
end
