require "spec_helper"

feature "Searching", js: true do
  let(:user) { create(:user) }

  scenario "In the expenses index page" do
    hotel  = "Hotel fee"
    travel = "Travel fee"
    create(:expense, user: user, description: hotel)
    create(:expense, user: user, description: travel)
    visit expenses_path(as: user)
    expect(page).to have_content hotel
    expect(page).to have_content travel
    fill_in "Search", with: hotel
    expect(page).to     have_content hotel
    expect(page).to_not have_content hotel
  end
end
