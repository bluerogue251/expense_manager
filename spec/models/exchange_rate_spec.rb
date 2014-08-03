require 'spec_helper'

describe ExchangeRate do
  it { should validate_numericality_of(:rate).is_greater_than(0) }
  it { should validate_presence_of(:starts_on) }

  it { should ensure_inclusion_of(:anchor).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }
  it { should ensure_inclusion_of(:float).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }

  it "Cannot have the same anchor and float currencies" do
    rate = ExchangeRate.new(anchor: "USD", float: "USD")
    expect(rate).to_not be_valid
    expect(rate.errors.full_messages).to include "Anchor and float currencies cannot be the same"
  end
end
