require 'spec_helper'

describe Dashboard do
  describe "#month" do
    it "Is formatted as yyyy-mm" do
      user = User.new
      date = Date.parse("2013-12-25")
      dashboard = Dashboard.new(user, date)
      expect(dashboard.month).to eq "2013-12"
    end

    it "Defaults to the previous month" do
      Timecop.travel "2011-01-01" do
        user = User.new
        dashboard = Dashboard.new(user)
        expect(dashboard.month). to eq "2010-12"
      end
    end
  end

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

    specify "For approved expenses scoped to the specified month" do
      user = create(:user, default_currency: "HKD")
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 5.95)
      # Included in sum, becuase they are from the previous month
      2.times { create(:expense, date: 1.month.ago,  user: user, currency: "CAD", amount: "250.99", status: "Approved") }
      # NOT included in sum, becuase they are from two months ago
      2.times { create(:expense, date: 2.months.ago, user: user, currency: "CAD", amount: "250.99", status: "Approved") }
      dashboard = Dashboard.new(user, 1.month.ago)
      expect(dashboard.approved_total).to eq BigDecimal.new("2986.781") # 250.99 * 2 * 5.95
    end
  end
end
