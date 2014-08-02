require 'spec_helper'

describe ExchangeRate do
  it { should validate_presence_of(:anchor) }
  it { should validate_presence_of(:float) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:starts_on) }
end
