require 'spec_helper'

describe Payment do

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:date) }
  it { should ensure_inclusion_of(:currency).in_array(ExchangeRate::CURRENCIES) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }

end
