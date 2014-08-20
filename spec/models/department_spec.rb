require 'spec_helper'

describe Department do
  it { should validate_presence_of(:name) }
  it { should have_many(:job_title_assignments) }
  it { should have_many(:expenses) }
end
