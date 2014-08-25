require "spec_helper"

feature "Exchange Rates", js: true do
  scenario "Creating successfully" do
    user = create(:user)
    visit exchange_rates_path(as: user)
    expect(ExchangeRate.count).to eq 0
    fast_fill_form(:exchange_rate, anchor: "USD", float: "CNY", rate: "6.21", starts_on: "2011-01-01", ends_on: "2011-02-01")
    click_button "Create Exchange rate"
    expect(page).to have_selector "td", text: "6.21"
    expect(ExchangeRate.count).to eq 1
  end

  scenario "Creating with invalid data" do
    user = create(:user)
    visit exchange_rates_path(as: user)
    expect(ExchangeRate.count).to eq 0
    fast_fill_form(:exchange_rate, anchor: "USD", float: "USD", rate: "1", starts_on: "2011-01-01", ends_on: "2011-02-01")
    click_button "Create Exchange rate"
    expect(page).to have_selector ".error", text: "Anchor and float currencies cannot be the same"
    expect(ExchangeRate.count).to eq 0
  end

  scenario "Destroying" do
    user = create(:user)
    ex_rate = create(:exchange_rate)
    visit exchange_rates_path(as: user)
    destroy_link = "destroy_exchange_rate_#{ex_rate.id}"
    click_link destroy_link
    expect(page).to_not have_link destroy_link
    expect(ExchangeRate.exists?(ex_rate)).to be_false
  end
end
