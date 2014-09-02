require "spec_helper"

describe UsersController do

  it "Does not permit #email in params" do
    old_email = "old_email@example.com"
    user = create(:user, email: old_email)
    sign_in_as(user)
    expect(user.email).to eq old_email
    patch :update, id: user.id, user: { email: "new_email@example.com" }
    expect(user.reload.email).to eq old_email
  end

end
