require 'spec_helper'

describe Expense do
  it { should belong_to(:user) }
  it { should belong_to(:category) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:amount) }

  it { should ensure_inclusion_of(:status).in_array(Expense::STATUSES) }
  it { should ensure_inclusion_of(:currency).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }

  describe "#status" do
    it "Should have a default value of 'Pending'" do
      expect(Expense.new.status).to eq "Pending"
    end
  end

  describe "self#by_category_in('currency_code')" do
    it "Converts expenses to a common currency, then sums them up" do
      create(:exchange_rate, anchor: "USD", float: "CNY", rate: 6, starts_on: "2000-01-01")
      create(:expense, currency: "CNY", amount: 6, date: "2000-01-01")
      expense = Expense.by_category_in("USD").first
      expect(expense.sum_currency).to eq "USD"
      expect(expense.sum_amount).to eq "1"
    end
  end
end
