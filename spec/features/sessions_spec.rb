require "spec_helper"

feature "User sessions" do
  scenario "Unauthenticated users are redirected to sign in page" do
    visit root_path
    expect(current_path).to eq(sign_in_path)
  end

  scenario "Sign in directs users to the root path" do
    create(:user, email: "test@example.com", password: "password")
    visit sign_in_path
    fill_in "session_email", with: "test@example.com"
    fill_in "session_password", with: "password"
    click_button 'Sign in'
    expect(current_path).to eq(root_path)
  end
end
