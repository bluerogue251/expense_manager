require 'spec_helper'

describe JobTitleAssignment do
  it { should belong_to(:user) }
  it { should belong_to(:job_title) }
  it { should belong_to(:department) }
end
