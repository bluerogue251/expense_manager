require 'spec_helper'

describe JobTitleAssignment do
  it { should belong_to(:user) }
  it { should belong_to(:job_title) }
  it { should belong_to(:department) }
  it { should have_many(:expenses) }

  describe "Database-level validation of starts_on and ends_on", js: true do
    it "Does not permit a user to have a start date that overlaps an existing range" do
      user = create(:user)
      create(:job_title_assignment, user: user, starts_on: "1999-10-15", ends_on: "2000-10-15")
      expect {
        create(:job_title_assignment, user: user, starts_on: "1999-10-30", ends_on: "2000-10-30")
      }.to raise_error ActiveRecord::StatementInvalid
    end

    it "Does not permit a user to have an end date that overlaps an existing range" do
      user = create(:user)
      create(:job_title_assignment, user: user, starts_on: "1999-10-15", ends_on: "2000-10-15")
      expect {
        create(:job_title_assignment, user: user, starts_on: "1998-10-30", ends_on: "1999-10-30")
      }.to raise_error ActiveRecord::StatementInvalid
    end

    it "Permits updating (bug regression test)" do
      user = create(:user)
      job_title_assignment = create(:job_title_assignment, user: user, starts_on: "1999-10-15", ends_on: "2000-10-15")
      job_title_assignment.update!(starts_on: "1999-10-14")
      # No error is thrown and the record is actually updated correctly:
      expect(job_title_assignment.reload.starts_on).to eq Date.parse("1999-10-14")
    end
  end
end
