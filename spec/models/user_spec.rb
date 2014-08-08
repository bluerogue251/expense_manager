require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should ensure_inclusion_of(:default_currency).in_array(ExchangeRate::CURRENCIES) }

  it { should have_many(:job_titles).through(:job_title_assignments) }
  it { should have_many(:departments).through(:job_title_assignments) }
  it { should have_many(:expenses) }
end
