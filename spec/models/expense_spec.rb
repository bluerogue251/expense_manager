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
      create(:exchange_rate, anchor: "USD", float: "CNY", rate: 6, starts_on: "2000-01-01", ends_on: "2000-01-01")
      create(:expense, currency: "USD", amount: 1, date: "2000-01-01")
      expense = Expense.by_category_in("CNY").load.first
      expect(expense.sum_currency).to eq "CNY"
      expect(expense.sum_amount).to eq BigDecimal.new(6)
    end

    it "Uses the correct exchange rate based on the target currency" do
      create(:exchange_rate, anchor: "CNY", float: "USD", rate: 0.16)
      create(:exchange_rate, anchor: "HKD", float: "CNY", rate: 0.75)
      create(:exchange_rate, anchor: "CNY", float: "HKD", rate: 1.10)
      create(:expense, currency: "CNY", amount: 100, date: "2000-01-01")
      expense = Expense.by_category_in("USD").load.first
      expect(expense.sum_currency).to eq "USD"
      expect(expense.sum_amount).to eq BigDecimal.new(16)
    end

    it "Uses the correct exchange rate based on the date" do
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 5, starts_on: "2014-05-01", ends_on: "2014-05-31")
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 6, starts_on: "2014-06-01", ends_on: "2014-06-30") # This one will be used
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 7, starts_on: "2014-07-01", ends_on: "2014-07-31")
      create(:expense, currency: "CAD", amount: 10, date: "2014-06-15")
      expense = Expense.by_category_in("HKD").load.first
      expect(expense.sum_currency).to eq "HKD"
      expect(expense.sum_amount).to eq BigDecimal.new(60)
    end
  end
end
