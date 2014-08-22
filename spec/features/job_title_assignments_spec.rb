require 'spec_helper'

feature "Job title assignments" do
  scenario "Adding a new one" do
    department = create(:department)
    job_title =  create(:job_title)
    user = create(:user)
    expect(user.job_title_assignments.count).to eq 0
    visit edit_user_path(user, as: user)
    select department.name, from: "Department"
    select job_title.name,  from: "Job title"
    fill_in "Starts on",    with: "1979-01-10"
    fill_in "Ends on",      with: "2009-12-14"
    click_on "Update User"
    expect(user.job_title_assignments.count).to eq 1
    jta = user.job_title_assignments.first
    expect(jta.department).to eq department
    expect(jta.job_title).to  eq job_title
    expect(jta.starts_on).to  eq Date.parse("1979-01-10")
    expect(jta.ends_on).to    eq Date.parse("2009-12-14")
  end

  scenario "Deleting", js: true do
    user = create(:user)
    jta = create(:job_title_assignment, user: user)
    expect(user.job_title_assignments.count).to eq 1
    visit edit_user_path(user, as: user)
    first(:link, "destroy").click
    click_button "Update User"
    expect(page).to have_selector "#flash_success", text: "User profile updated"
    expect(user.job_title_assignments.count).to eq 0
  end
end
