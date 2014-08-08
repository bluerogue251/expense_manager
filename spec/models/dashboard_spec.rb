require 'spec_helper'

describe Dashboard do
  it "Has counts of Rejected and Pending expenses for a particular user" do
    user = create(:user)
    2.times { create(:expense, user: user, status: "Rejected") }
    3.times { create(:expense, user: user, status: "Pending")  }
    dashboard = Dashboard.new(user)
    expect(dashboard.rejected_count).to eq 2
    expect(dashboard.pending_count).to eq 3
  end

  describe "Total rejected amount is based on in the user's default currency" do
    specify "For rejected expenses" do
      user = create(:user, default_currency: "CAD")
      create(:exchange_rate, anchor: "USD", float: "CAD", rate: 1.1)
      2.times { create(:expense, user: user, currency: "USD", amount: "10", status: "Rejected") }
      dashboard = Dashboard.new(user)
      expect(dashboard.rejected_total).to eq BigDecimal.new('22')
    end

    specify "For pending expenses" do
      user = create(:user, default_currency: "CNY")
      create(:exchange_rate, anchor: "USD", float: "CNY", rate: 6.2)
      2.times { create(:expense, user: user, currency: "USD", amount: "100", status: "Pending") }
      dashboard = Dashboard.new(user)
      expect(dashboard.pending_total).to eq BigDecimal.new("1240")
    end
  end
end
