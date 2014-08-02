class JobTitleAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :job_title
  belongs_to :department
end
