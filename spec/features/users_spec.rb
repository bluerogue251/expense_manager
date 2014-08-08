require 'spec_helper'

feature "Users" do
  let(:user) { create(:user, name: "old name", email: "old@old.com", default_currency: "USD") }

  scenario "Updating" do
    visit edit_user_path(user, as: user)
    fill_form(:user, name: "new name", email: "new@new.com", default_currency: "CNY")
    click_button "Update User"
    expect(page).to have_selector "#flash_success", text: "User profile updated"
    user.reload
    expect(user.name).to eq "new name"
    expect(user.email).to eq "new@new.com"
    expect(user.default_currency).to eq "CNY"
  end
end
