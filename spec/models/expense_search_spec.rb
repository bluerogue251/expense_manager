require 'spec_helper'

describe "Expense search", search: true do
  it "Reindexes expense#department_name on job_title_assignment saving" do
    user = create(:user)
    department = create(:department, name: "test department")
    expense = create(:expense, user:user)
    jta = create(:job_title_assignment, user: user, department: department)
    results = Expense.search { fulltext "test department" }.results
    expect(results).to eq [expense]
    jta.destroy!
    new_results = Expense.search { fulltext "test department" }.results
    expect(new_results).to eq []
  end

  it "Reindexes expense#job_title_name on job_title_assignment saving" do
    user = create(:user)
    job_title = create(:job_title, name: "test job title")
    expense = create(:expense, user: user)
    create(:job_title_assignment, user: user, job_title: job_title)
    results = Expense.search { fulltext "test job title" }.results
    expect(results).to eq [expense]
  end

  it "Reindexes expense#user_name on user saving" do
    user = create(:user, name: "old name")
    expense = create(:expense, user: user)
    user.update!(name: "new name")
    results = Expense.search { fulltext "new" }.results
    expect(results).to eq [expense]
  end

  it "Reindexes expense#job_title_name on job_title saving" do
    user = create(:user)
    job_title = create(:job_title)
    create(:job_title_assignment, user: user, job_title: job_title)
    expense = create(:expense, user: user)
    job_title.update!(name: "new_test_job_title")
    results = Expense.search { fulltext "new_test_job_title" }.results
    expect(results).to eq [expense]
  end

  it "Reindexes expense#department_name on department saving" do
    user = create(:user)
    department = create(:department)
    create(:job_title_assignment, user: user, department: department)
    expense = create(:expense, user: user)
    department.update!(name: "new_test_department")
    results = Expense.search { fulltext "new_test_department" }.results
    expect(results).to eq [expense]
  end
end
