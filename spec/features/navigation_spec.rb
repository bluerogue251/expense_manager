require 'spec_helper'

feature "Navigation" do
  scenario "Clicking the Dashboard link navigates to the dashboard" do
    user = create(:user)
    visit user_expenses_path(as: user)
    click_link "Dashboard"
    expect(current_path).to eq dashboard_path
  end

  scenario "Clicking the Expenses link navigates to the expense index page" do
    user = create(:user)
    visit root_path(as: user)
    click_link "My expenses"
    expect(current_path).to eq user_expenses_path
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
    click_link "All expenses"
    expect(current_path).to eq expenses_path
  end

  scenario "Clicking the Exchange Rates link navigates to the exchange rates page" do
    user = create(:user)
    visit root_path(as: user)
    click_link "Exchange rates"
    expect(current_path).to eq exchange_rates_path
  end
end
