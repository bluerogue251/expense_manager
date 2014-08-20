require 'spec_helper'

describe Expense do
  it { should belong_to(:user) }
  it { should belong_to(:category) }
  it { should have_one(:expense_job_title_assignment) }
  it { should have_one(:job_title_assignment).through(:expense_job_title_assignment) }

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

  describe "self#sum_in('currency_code')" do
    it "Converts expenses to a common currency, then sums them up" do
      create(:exchange_rate, anchor: "USD", float: "CNY", rate: 6, starts_on: "2000-01-01", ends_on: "2000-01-01")
      create(:expense, currency: "USD", amount: 1, date: "2000-01-01")
      expect(Expense.sum_in("CNY")).to eq BigDecimal.new(6)
    end

    it "Uses the correct exchange rate based on the target currency" do
      create(:exchange_rate, anchor: "CNY", float: "USD", rate: 0.16)
      create(:exchange_rate, anchor: "HKD", float: "CNY", rate: 0.75)
      create(:exchange_rate, anchor: "CNY", float: "HKD", rate: 1.10)
      create(:expense, currency: "CNY", amount: 100, date: "2000-01-01")
      expect(Expense.sum_in("USD")).to eq BigDecimal.new(16)
    end

    it "Uses the correct exchange rate based on the date" do
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 5, starts_on: "2014-05-01", ends_on: "2014-05-31")
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 6, starts_on: "2014-06-01", ends_on: "2014-06-30") # This one will be used
      create(:exchange_rate, anchor: "CAD", float: "HKD", rate: 7, starts_on: "2014-07-01", ends_on: "2014-07-31")
      create(:expense, currency: "CAD", amount: 10, date: "2014-06-15")
      expect(Expense.sum_in("HKD")).to eq BigDecimal.new(60)
    end
  end

  describe "self#for_month" do
    it "Filters expenses to include only those in that particular month AND YEAR" do
      feb_2013 = create(:expense, date: "2013-02-10")
      jan_2014 = create(:expense, date: "2014-01-15")
      feb_2014 = create(:expense, date: "2014-02-20")
      mar_2014 = create(:expense, date: "2014-03-25")
      expect(Expense.for_month("2014-02")).to eq [feb_2014]
    end
  end

  describe "#department_name" do
    it "Returns the department name of the user, on the date of the expense" do
      user = create(:user)
      department = create(:department, name: "test department")
      create(:job_title_assignment, user: user, department: department)
      expense = create(:expense, user: user)
      expect(expense.department_name).to eq "test department"
    end

    it "Can be nil without throwing an error" do
      expense = Expense.new
      expect(expense.department_name).to be_nil
    end
  end

  describe "#job_title_name" do
    it "Returns the job_title_name of the user, on the date of the expense" do
      user = create(:user)
      job_title = create(:job_title, name: "test job title")
      create(:job_title_assignment, user: user, job_title: job_title)
      expense = create(:expense, user: user)
      expect(expense.job_title_name).to eq "test job title"
    end

    it "Can be nil without throwing an error" do
      expense = Expense.new
      expect(expense.job_title_name).to be_nil
    end
  end
end
