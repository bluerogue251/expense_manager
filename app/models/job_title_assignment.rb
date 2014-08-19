class JobTitleAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :job_title
  belongs_to :department
  has_many :expense_job_title_assignments
  has_many :expenses
end
