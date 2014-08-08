require 'spec_helper'

describe Dashboard do
  let(:user) { create(:user) }

  it "Has counts of Rejected and Pending expenses for a particular user" do
    2.times { create(:expense, user: user, status: "Rejected") }
    3.times { create(:expense, user: user, status: "Pending")  }
    dashboard = Dashboard.new(user)
    expect(dashboard.rejected_count).to eq 2
    expect(dashboard.pending_count).to eq 3
  end

  describe "Total rejected amount is based on in the user's default currency" do
    specify "For rejected expenses" do
      pending
    end

    specify "For pending expenses" do
      pending
    end
  end
end
