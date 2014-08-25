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

  scenario "Updating successfully" do
    user = create(:user)
    jta = create(:job_title_assignment, user: user)
    new_department = create(:department)
    visit edit_user_path(user, as: user)
    select new_department.name, from: "user_job_title_assignments_attributes_0_department_id"
    click_button "Update User"
    expect(page).to have_selector "#flash_success", text: "User profile updated"
    expect(jta.reload.department).to eq new_department
  end

  scenario "Updating with an overlapping date range" do
    user = create(:user)
    first_jta  = create(:job_title_assignment, user: user, starts_on: "2000-01-01", ends_on: "2000-12-31")
    second_jta = create(:job_title_assignment, user: user, starts_on: "2001-01-01", ends_on: "2001-01-01")
    visit edit_user_path(user, as: user)
    fill_in "user_job_title_assignments_attributes_0_starts_on", with: "2001-01-01"
    click_button "Update User"
    expect(page).to have_selector "#flash_error", text: "User job title assignments have overlapping dates"
  end
end
