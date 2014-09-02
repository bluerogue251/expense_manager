require "spec_helper"

describe "Users/Expenses" do
  scenario "Indexing only shows the signed-in user's expenses" do
    signed_in_user = create(:user)
    signed_in_users_description = "signed in user's description"
    other_users_description = "other user's description"
    create(:expense, description: signed_in_users_description, user: signed_in_user)
    create(:expense, description: other_users_description)
    Sunspot.commit
    visit users_expenses_path(as: signed_in_user)
    expect(page).to     have_content signed_in_users_description
    expect(page).to_not have_content other_users_description
  end
end
