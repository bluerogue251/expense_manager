class ExpenseJobTitleAssignment < ActiveRecord::Base
  belongs_to :expense
  belongs_to :job_title_assignment
end
