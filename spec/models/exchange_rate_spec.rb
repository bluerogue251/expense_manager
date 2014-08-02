require 'spec_helper'

describe ExchangeRate do
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:starts_on) }

  it { should ensure_inclusion_of(:anchor).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }
  it { should ensure_inclusion_of(:float).in_array(ExchangeRate::CURRENCIES).allow_blank(false) }
end
