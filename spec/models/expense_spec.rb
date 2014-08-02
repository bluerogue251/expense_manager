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
end
