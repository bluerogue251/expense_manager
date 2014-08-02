require 'spec_helper'

describe Expense do
  it { should belong_to(:user) }
  it { should belong_to(:category) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:currency) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:status) }
end
