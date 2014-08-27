require 'spec_helper'

describe ExchangeRate do
  it { should validate_numericality_of(:rate).is_greater_than(0) }
  it { should validate_presence_of(:starts_on) }
  it { should validate_presence_of(:ends_on) }

  it { should ensure_inclusion_of(:anchor).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }
  it { should ensure_inclusion_of(:float).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }

  it "Cannot have the same anchor and float currencies" do
    rate = ExchangeRate.new(anchor: "USD", float: "USD")
    expect(rate).to_not be_valid
    expect(rate.errors.full_messages).to include "Anchor and float currencies cannot be the same"
  end

  describe "self#by_starts_on" do
    it "Orders the records by starts_on date, ascending" do
      middle   = create(:exchange_rate, starts_on: "1997-01-01", ends_on: "1997-01-02")
      earliest = create(:exchange_rate, starts_on: "1996-01-01", ends_on: "1996-01-02")
      latest   = create(:exchange_rate, starts_on: "1998-01-01", ends_on: "1998-01-02")
      expect(ExchangeRate.by_starts_on).to eq [earliest, middle, latest]
    end
  end

  describe "Database-level constraint on overlapping date ranges" do
    it "Prevents two exchange rates with the same currencies from having overlapping date ranges" do
      create(:exchange_rate, anchor: "USD", float: "CNY", starts_on: "2001-01-01", ends_on: "2001-01-10")
      expect {
        create(:exchange_rate, anchor: "USD", float: "CNY", starts_on: "2001-01-02", ends_on: "2000-01-11")
      }.to raise_error ActiveRecord::StatementInvalid
    end
  end
end
